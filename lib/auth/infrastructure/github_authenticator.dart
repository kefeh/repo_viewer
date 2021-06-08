import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:oauth2/oauth2.dart';
import 'package:repo_viewer/auth/dormain/auth_failure.dart';
import 'package:repo_viewer/auth/infrastructure/credential_storage/credential_storage.dart';
import 'package:http/http.dart' as http;
import 'package:repo_viewer/core/shared/encoders.dart';

class GithubOAuthHttpClient extends http.BaseClient {
  final httpClient = http.Client();
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Accept'] = 'application/json';
    return httpClient.send(request);
  }
}

class GithubAuthenticator {
  final CredentialStorage _credentialStorage;
  final Dio _dio;

  GithubAuthenticator(this._credentialStorage, this._dio);

  static const clientId = 'caf56c4ead1731927884';
  static const clientSecrete = 'b8816e5b778dd619213a3cb7563511d3b9d108cf';
  static const scopes = ['read:user', 'repo'];
  static final authorizationEndpoint =
      Uri.parse('https://github.com/login/oauth/authorize');
  static final tokenEndpoint =
      Uri.parse('https://github.com/login/oauth/access_token');
  static final revocationEndpoint =
      Uri.parse('https://api.github.com/applications/$clientId/token');
  static final redirectEndpoint = Uri.parse('http://localhost:3000/callback');

  Future<Credentials?> getSignedInCredentials() async {
    try {
      final storedCredentials = await _credentialStorage.read();
      if (storedCredentials!.canRefresh && storedCredentials.isExpired) {
        //TODO: refresh the token
      }
      return storedCredentials;
    } on PlatformException {
      return null;
    }
  }

  Future<bool> isSignedIn() =>
      getSignedInCredentials().then((credentials) => credentials != null);

  AuthorizationCodeGrant createGrant() {
    return AuthorizationCodeGrant(
        clientId, authorizationEndpoint, tokenEndpoint,
        secret: clientSecrete, httpClient: GithubOAuthHttpClient());
  }

  Uri getAuthorizationUri(AuthorizationCodeGrant grant) {
    return grant.getAuthorizationUrl(redirectEndpoint, scopes: scopes);
  }

  Future<Either<AuthFailure, Unit>> handleAuthorizationFailure(
      AuthorizationCodeGrant grant, Map<String, String> queryParams) async {
    try {
      final httpClient = await grant.handleAuthorizationResponse(queryParams);
      await _credentialStorage.save(httpClient.credentials);
      return right(unit);
    } on FormatException {
      return left(const AuthFailure.server());
    } on AuthorizationException catch (e) {
      return left(AuthFailure.server('${e.error}: ${e.description}'));
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }

  Future<Either<AuthFailure, Unit>> signOut() async {
    final accessToken = await _credentialStorage
        .read()
        .then((credentials) => credentials?.accessToken);
    final userNameAndPassword =
        stringToBase64.encode('$clientId:$clientSecrete');
    try {
      _dio.deleteUri(
        revocationEndpoint,
        data: {
          "access_token": accessToken,
        },
        options: Options(
          headers: {
            'Authorization': 'basic $userNameAndPassword',
          },
        ),
      );
      await _credentialStorage.clear();
      return right(unit);
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }
}
