import 'package:foodie/common/scaffold_with_bottom_nav.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/recipes/domain/recipe.dart';
import '../features/recipes/presentation/home_page/home_page.dart';
import '../features/recipes/presentation/recipe_details/recipe_details_page.dart';
import 'route_names.dart';
import 'route_paths.dart';

class AppRouter {
  AppRouter(WidgetRef ref) {
    router = _getRouter(ref);
  }
  late GoRouter router;
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  GoRouter _getRouter(WidgetRef ref) => GoRouter(
        initialLocation: RoutePaths.home,
        debugLogDiagnostics: true,
        routes: [
          ShellRoute(
              navigatorKey: _shellNavigatorKey,
              builder: (context, state, child) =>
                  ScaffoldWithBottomNavBar(child: child),
              routes: [
                GoRoute(
                    path: RoutePaths.home,
                    name: RouteNames.home,
                    pageBuilder: (context, state) => MaterialPage(
                          key: state.pageKey,
                          child: const HomePage(),
                        ),
                    routes: [
                      GoRoute(
                        path: '${RoutePaths.detail}/:id',
                        name: RouteNames.detail,
                        builder: (context, state) {
                          final recipe = state.extra as Recipe;
                          return RecipeDetailsPage(recipe: recipe);
                        },
                      )
                    ]),
              ]),
        ],
      );
}
