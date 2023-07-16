// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/authentification/data/auth_repository.dart';
import '../features/authentification/presentation/log_in/log_in_screen.dart';
import '../features/authentification/presentation/sign_up/sign_up_screen.dart';
import '../features/challenges/presentation/challenges_page.dart';
import '../features/friends/friends_page.dart';
import '../features/onboarding/presentation/onboarding.dart';
import '../features/profile/presentation/profile_page.dart';
import '../features/recipes/domain/recipe.dart';
import '../features/recipes/presentation/home_page/home_page.dart';
import '../features/recipes/presentation/recipe_details/recipe_details_page.dart';
import '../features/recipes/presentation/recipe_steps/recipe_steps_page.dart';
import '../features/recipes/presentation/saved_recipes/saved_recipes_page.dart';
import 'app_route.dart';
import 'not_found_page.dart';
import 'scaffold_with_bottom_nav.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');
  final auth = ref.watch(authRepositoryProvider);
  return GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      errorBuilder: (context, state) => const NotFoundPage(),
      navigatorKey: _rootNavigatorKey,
      redirect: (context, state) {
        final user = auth.currentUser;
        final isLoggedIn = user != null;
        if (!isLoggedIn) {
          if (state.location == '/') return '/onboarding';
        }
        return null;
      },
      routes: <RouteBase>[
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state, child) {
              return NoTransitionPage(
                  key: state.pageKey,
                  child: ScaffoldWithBottomNavBar(
                      key: state.pageKey, child: child));
            },
            routes: <RouteBase>[
              GoRoute(
                  path: '/',
                  name: AppRoute.home.name,
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                      key: state.pageKey,
                      child: HomePage(
                        key: state.pageKey,
                      ),
                    );
                  },
                  routes: <RouteBase>[
                    GoRoute(
                        path: 'detail/:id',
                        name: AppRoute.detail.name,
                        pageBuilder: (context, state) {
                          final recipe = state.extra as Recipe;
                          return NoTransitionPage(
                            key: state.pageKey,
                            child: RecipeDetailsPage(
                                key: state.pageKey, recipe: recipe),
                          );
                        },
                        routes: <RouteBase>[
                          GoRoute(
                            path: 'steps',
                            name: AppRoute.steps.name,
                            pageBuilder: (context, state) {
                              final recipe = state.extra as Recipe;
                              return NoTransitionPage(
                                key: state.pageKey,
                                child: RecipeStepsPage(
                                    key: state.pageKey, recipe: recipe),
                              );
                            },
                          )
                        ]),
                  ]),
              GoRoute(
                path: '/challenges',
                name: AppRoute.challenges.name,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: ChallengesPage(key: state.pageKey),
                  );
                },
              ),
              GoRoute(
                path: '/saved',
                name: AppRoute.saved.name,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: SavedRecipesPage(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
              GoRoute(
                path: '/friends',
                name: AppRoute.friends.name,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: FriendsPage(key: state.pageKey),
                  );
                },
              ),
              GoRoute(
                path: '/profile',
                name: AppRoute.profile.name,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: ProfilePage(key: state.pageKey),
                  );
                },
              ),
            ]),
        GoRoute(
          path: '/onboarding',
          name: AppRoute.onboarding.name,
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const Onboarding(),
        ),
        GoRoute(
          path: '/signup',
          name: AppRoute.signup.name,
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: '/login',
          name: AppRoute.login.name,
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const LogInScreen(),
        ),
      ]);
});
