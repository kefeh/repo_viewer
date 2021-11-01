import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:oauth2/oauth2.dart';
import 'package:repo_viewer/auth/dormain/auth_failure.dart';
import 'package:repo_viewer/auth/infrastructure/credentials_storage/credentials_storage.dart';
import 'package:http/http.dart' as http;
import 'package:repo_viewer/core/infrastructure/dio_extensions.dart';
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
  final CredentialsStorage _credentialsStorage;
  final Dio _dio;

  GithubAuthenticator(this._credentialsStorage, this._dio);

  static const clientId = "caf56c4ead1731927884";
  static const clientSecrete = "a785465e752da41086ae934b29a701468ea83c58";
  static const scopes = ["read:user", "repo"];

  static final authorizationEndpoint =
      Uri.parse("https://github.com/login/oauth/authorize");
  static final tokenEndpoint =
      Uri.parse("https://github.com/login/oauth/access_token");

  static final redirectUri = Uri.parse("http://localhost:3000/callback");
  static final revokationEndpoint =
      Uri.parse('https://api.github.com/applications/$clientId/token');

  Future<Credentials?> getSignedInCredentials() async {
    try {
      final storedCredentials = await _credentialsStorage.read();
      if (storedCredentials != null) {
        if (storedCredentials.canRefresh && storedCredentials.isExpired) {
          final failureOrCredentials = await refresh(storedCredentials);
          failureOrCredentials.fold((l) => null, (r) => r);
        }
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
      clientId,
      authorizationEndpoint,
      tokenEndpoint,
      secret: clientSecrete,
      httpClient: GithubOAuthHttpClient(),
    );
  }

  Uri getAuthorizationUrl(AuthorizationCodeGrant grant) {
    return grant.getAuthorizationUrl(
      redirectUri,
      scopes: scopes,
    );
  }

  Future<Either<AuthFailure, Unit>> handleAuthorizationResponse(
    AuthorizationCodeGrant grant,
    Map<String, String> queryParams,
  ) async {
    try {
      final httpClient = await grant.handleAuthorizationResponse(queryParams);
      await _credentialsStorage.save(httpClient.credentials);
      return right(unit);
    } on FormatException {
      return left(const AuthFailure.server());
    } on AuthorizationException catch (e) {
      return left(AuthFailure.server("${e.error}: ${e.description}"));
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }

  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      final usernameAndPassword =
          stringToBase64.encode('$clientId:$clientSecrete');
      final accessToken = await _credentialsStorage
          .read()
          .then((credentials) => credentials?.accessToken);
      try {
        await _dio.deleteUri(
          revokationEndpoint,
          data: {
            'access_token': accessToken,
          },
          options: Options(
            headers: {
              'Authorization': "bearer $usernameAndPassword",
            },
          ),
        );
      } on DioError catch (e) {
        if (e.isNoConnectionError) {
          print("Token not revoked");
        } else {
          rethrow;
        }
      }
      return clearCredentialsStorage();
    } on PlatformException {
      return left(
        const AuthFailure.storage(),
      );
    }
  }

  Future<Either<AuthFailure, Unit>> clearCredentialsStorage() async {
    try {
      await _credentialsStorage.clear();
      return right(unit);
    } on PlatformException {
      return const Left(AuthFailure.storage());
    }
  }

  Future<Either<AuthFailure, Credentials>> refresh(
      Credentials credentials) async {
    try {
      final refreshCredentials = await credentials.refresh(
        identifier: clientId,
        secret: clientSecrete,
        httpClient: GithubOAuthHttpClient(),
      );
      await _credentialsStorage.save(refreshCredentials);
      return right(refreshCredentials);
    } on AuthorizationException catch (e) {
      return left(AuthFailure.server('${e.error}:${e.description}'));
    } on FormatException {
      return left(const AuthFailure.server());
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }
}
