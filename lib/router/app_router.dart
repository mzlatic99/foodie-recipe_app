import 'package:foodie/common/scaffold_with_bottom_nav.dart';
import 'package:foodie/features/authentification/data/auth_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/authentification/presentation/log_in/log_in_screen.dart';
import '../features/authentification/presentation/sign_up/sign_up_screen.dart';
import '../features/challanges/challanges_page.dart';
import '../features/friends/friends_page.dart';
import '../features/onboarding/presentation/onboarding.dart';
import '../features/profile/profile_page.dart';
import '../features/recipes/domain/recipe.dart';
import '../features/recipes/presentation/home_page/home_page.dart';
import '../features/recipes/presentation/recipe_details/recipe_details_page.dart';
import '../features/recipes/presentation/recipe_steps/recipe_steps_page.dart';
import '../features/recipes/presentation/saved_recipes/saved_recipes_page.dart';
import 'app_route.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorChallangesKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellChallanges');
final _shellNavigatorSavedKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellSaved');
final _shellNavigatorFriendsKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellFriends');
final _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

final goRouterProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authRepositoryProvider);

  return GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigatorKey,
      redirect: (context, state) {
        final user = auth.currentUser;
        final isLoggedIn = user != null;
        if (isLoggedIn) {
          if (state.location == '/') return '/home';
        }
        return null;
      },
      routes: [
        GoRoute(
            path: '/',
            name: AppRoute.onboarding.name,
            pageBuilder: (context, state) => const MaterialPage(
                  child: Onboarding(),
                ),
            routes: [
              GoRoute(
                path: 'signup',
                name: AppRoute.signup.name,
                pageBuilder: (context, state) => const MaterialPage(
                  child: SignUpScreen(),
                ),
              ),
              GoRoute(
                path: 'login',
                name: AppRoute.login.name,
                pageBuilder: (context, state) => const MaterialPage(
                  child: LogInScreen(),
                ),
              ),
              StatefulShellRoute.indexedStack(
                  builder: (context, state, navigationShell) =>
                      ScaffoldWithBottomNavBar(child: navigationShell),
                  branches: [
                    StatefulShellBranch(
                        navigatorKey: _shellNavigatorHomeKey,
                        routes: [
                          GoRoute(
                            path: 'home',
                            parentNavigatorKey: _shellNavigatorHomeKey,
                            name: AppRoute.home.name,
                            builder: (context, state) {
                              return const HomePage();
                            },
                          ),
                        ]),
                    StatefulShellBranch(
                        navigatorKey: _shellNavigatorChallangesKey,
                        routes: [
                          GoRoute(
                            path: 'challanges',
                            name: AppRoute.challanges.name,
                            builder: (context, state) {
                              return const ChallangesPage();
                            },
                          ),
                        ]),
                    StatefulShellBranch(
                        navigatorKey: _shellNavigatorSavedKey,
                        routes: [
                          GoRoute(
                            path: 'saved',
                            name: AppRoute.saved.name,
                            builder: (context, state) {
                              return SavedRecipesPage();
                            },
                          ),
                        ]),
                    StatefulShellBranch(
                        navigatorKey: _shellNavigatorFriendsKey,
                        routes: [
                          GoRoute(
                            path: 'friends',
                            name: AppRoute.friends.name,
                            builder: (context, state) {
                              return const FriendsPage();
                            },
                          ),
                        ]),
                    StatefulShellBranch(
                        navigatorKey: _shellNavigatorProfileKey,
                        routes: [
                          GoRoute(
                            path: 'profile',
                            name: AppRoute.profile.name,
                            builder: (context, state) {
                              return const ProfilePage();
                            },
                          ),
                        ])
                  ]),
              GoRoute(
                  path: 'detail/:id',
                  name: AppRoute.detail.name,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final recipe = state.extra as Recipe;
                    return RecipeDetailsPage(recipe: recipe);
                  },
                  routes: [
                    GoRoute(
                      path: 'steps',
                      name: AppRoute.steps.name,
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        final recipe = state.extra as Recipe;
                        return RecipeStepsPage(recipe: recipe);
                      },
                    )
                  ])
            ]),
      ]);
});
