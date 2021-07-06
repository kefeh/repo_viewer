import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repo_viewer/auth/application/auth_notifier.dart';
import 'package:repo_viewer/auth/shared/providers.dart';
import 'package:repo_viewer/core/presentation/routes/app_router.gr.dart';
import 'package:repo_viewer/core/shared/providers.dart';

final inititializationProvider = FutureProvider<Unit>((ref) async {
  await ref.read(sembastProvider).init();
  final authnotifier = ref.read(authNotifierProvider.notifier);
  await authnotifier.checkAndUpdateAuthState();
  return unit;
});

class AppWidget extends StatelessWidget {
  final appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return ProviderListener(
      provider: inititializationProvider,
      onChange: (context, value) {},
      child: ProviderListener<AuthState>(
        provider: authNotifierProvider,
        onChange: (BuildContext context, state) {
          state.maybeMap(
            orElse: () {},
            authenticated: (_) {
              appRouter.pushAndPopUntil(const StarredReposRoute(),
                  predicate: (route) => false);
            },
            unauthenticated: (_) {
              appRouter.pushAndPopUntil(const SignInRoute(),
                  predicate: (route) => false);
            },
          );
        },
        child: MaterialApp.router(
          title: 'Repo Viewer',
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
        ),
      ),
    );
  }
}
