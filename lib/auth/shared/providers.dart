import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repo_viewer/auth/application/auth_notifier.dart';
import 'package:repo_viewer/auth/infrastructure/credentials_storage/credentials_storage.dart';
import 'package:repo_viewer/auth/infrastructure/credentials_storage/secure_credentials_storage.dart';
import 'package:repo_viewer/auth/infrastructure/github_authenticator.dart';
import 'package:repo_viewer/auth/infrastructure/oauth2_interceptor.dart';

final secureStorageProvider = Provider((ref) => const FlutterSecureStorage());
final credentialsStorageProvider = Provider<CredentialsStorage>(
  (ref) => SecureCredentialsStorage(ref.watch(secureStorageProvider)),
);
final dioForAuthProvider = Provider((ref) => Dio());

final oAuth2InterceptorProvider = Provider((ref) => OAuth2Interceptor(
    ref.watch(githubAuthenticatorProvider),
    ref.watch(dioForAuthProvider),
    ref.watch(authNotifierProvider.notifier)));
final githubAuthenticatorProvider = Provider(
  (ref) => GithubAuthenticator(
    ref.watch(credentialsStorageProvider),
    ref.watch(dioForAuthProvider),
  ),
);
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier(
          ref.watch(githubAuthenticatorProvider),
        ));
