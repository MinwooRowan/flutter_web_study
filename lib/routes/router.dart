import 'package:flutter/material.dart';
import 'package:flutter_web_study/presentation/screen/home/home_screen.dart';
import 'package:flutter_web_study/presentation/screen/home/screen/detail_screen.dart';
import 'package:flutter_web_study/presentation/screen/splash/root_screen.dart';
import 'package:flutter_web_study/presentation/screen/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/${HomeScreen.route}',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const RootScreen(),
        routes: [
          GoRoute(
            path: SplashScreen.route,
            name: SplashScreen.route,
            builder: (context, state) {
              return const SplashScreen();
            },
          ),
          GoRoute(
            path: HomeScreen.route,
            name: HomeScreen.route,
            builder: (context, state) {
              return const HomeScreen();
            },
            routes: [
              GoRoute(
                path: '/${HomeScreen.route}/${DetailScreen.route}:detailId',
                name: DetailScreen.route,
                builder: (context, state) {
                  final String? detailIdPathParam =
                      state.pathParameters['detailId'];
                  if (detailIdPathParam == null) {
                    return const HomeScreen();
                  }
                  final int? detailId = int.tryParse(detailIdPathParam);

                  if (detailId == null) {
                    return const HomeScreen();
                  }
                  return DetailScreen(detailId: detailId);
                },
                routes: [],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

CustomTransitionPage buildWithFadetTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  int duration = 0,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    transitionDuration: Duration(milliseconds: duration),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
