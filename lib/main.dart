import 'package:flutter/material.dart';
import 'package:flutter_web_study/environment/app_build.dart';
import 'package:flutter_web_study/routes/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  await AppBuild.init();
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
    );
  }
}
