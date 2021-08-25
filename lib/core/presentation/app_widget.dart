import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repo_viewer/auth/shared/providers.dart';
import 'package:repo_viewer/core/presentation/routes/app_router.gr.dart';

final initialisationProvider = FutureProvider<Unit>((ref) async {
  final authNotifier = ref.read(authNotifierProvider.notifier);
  await authNotifier.checkUpdateAuthStatus();
  return unit;
});

class AppWidget extends StatelessWidget {
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ProviderListener(
      provider: initialisationProvider,
      onChange: (context, value) {},
      child: MaterialApp.router(
        title: "Repo Viewer",
        routeInformationParser: appRouter.defaultRouteParser(),
        routerDelegate: appRouter.delegate(),
      ),
    );
  }
}
