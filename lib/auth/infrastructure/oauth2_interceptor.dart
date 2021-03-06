import 'package:dio/dio.dart';
import 'package:repo_viewer/auth/application/auth_notifier.dart';
import 'package:repo_viewer/auth/infrastructure/github_authenticator.dart';

class OAuth2Interceptor extends Interceptor {
  final GithubAuthenticator _authenticator;
  final Dio _dio;
  final AuthNotifier _authNotifier;

  OAuth2Interceptor(this._authenticator, this._dio, this._authNotifier);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final credentials = await _authenticator.getSignedInCredentials();
    final requestOptions = options
      ..headers.addAll(
        credentials == null
            ? {}
            : {
                'Authorization': 'Bearer ${credentials.accessToken}',
              },
      );
    handler.next(requestOptions);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    final errorResponse = err.response;
    if (errorResponse != null && errorResponse.statusCode == 401) {
      final credentials = await _authenticator.getSignedInCredentials();
      credentials != null && credentials.canRefresh
          ? _authenticator.refresh(credentials)
          : await _authenticator.clearCredentialsStorage();

      _authNotifier.checkUpdateAuthStatus();
      final refreshCredentials = await _authenticator.getSignedInCredentials();
      if (refreshCredentials != null) {
        handler.resolve(await _dio.fetch(err.requestOptions
          ..headers['Authorization'] =
              'Bearer ${refreshCredentials.accessToken}'));
      }
    } else {
      handler.next(err);
    }
  }
}
