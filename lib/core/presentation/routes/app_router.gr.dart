// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../../auth/presentation/authorization_page.dart' as _i6;
import '../../../auth/presentation/sign_in_page.dart' as _i4;
import '../../../Splash/presentation/splash.dart' as _i3;
import '../../../starred_repo/presentation/starred_repo_page.dart' as _i5;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i3.SplashPage();
        }),
    SignInRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i4.SignInPage();
        }),
    StarredReposRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i5.StarredReposPage();
        }),
    AuthorizationRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<AuthorizationRouteArgs>();
          return _i6.AuthorizationPage(
              key: args.key,
              authorizationUri: args.authorizationUri,
              onAuthorizationCodeRedirectAttempt:
                  args.onAuthorizationCodeRedirectAttempt);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashRoute.name, path: '/'),
        _i1.RouteConfig(SignInRoute.name, path: '/sign-in'),
        _i1.RouteConfig(StarredReposRoute.name, path: '/starred'),
        _i1.RouteConfig(AuthorizationRoute.name, path: '/auth')
      ];
}

class SplashRoute extends _i1.PageRouteInfo {
  const SplashRoute() : super(name, path: '/');

  static const String name = 'SplashRoute';
}

class SignInRoute extends _i1.PageRouteInfo {
  const SignInRoute() : super(name, path: '/sign-in');

  static const String name = 'SignInRoute';
}

class StarredReposRoute extends _i1.PageRouteInfo {
  const StarredReposRoute() : super(name, path: '/starred');

  static const String name = 'StarredReposRoute';
}

class AuthorizationRoute extends _i1.PageRouteInfo<AuthorizationRouteArgs> {
  AuthorizationRoute(
      {_i2.Key? key,
      required Uri authorizationUri,
      required void Function(Uri) onAuthorizationCodeRedirectAttempt})
      : super(name,
            path: '/auth',
            args: AuthorizationRouteArgs(
                key: key,
                authorizationUri: authorizationUri,
                onAuthorizationCodeRedirectAttempt:
                    onAuthorizationCodeRedirectAttempt));

  static const String name = 'AuthorizationRoute';
}

class AuthorizationRouteArgs {
  const AuthorizationRouteArgs(
      {this.key,
      required this.authorizationUri,
      required this.onAuthorizationCodeRedirectAttempt});

  final _i2.Key? key;

  final Uri authorizationUri;

  final void Function(Uri) onAuthorizationCodeRedirectAttempt;
}
