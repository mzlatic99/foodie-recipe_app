import 'package:foodie/common/scaffold_with_bottom_nav.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/authentification/presentation/log_in/log_in_screen.dart';
import '../features/authentification/presentation/sign_up/sign_up_screen.dart';
import '../features/onboarding/presentation/onboarding.dart';
import '../features/recipes/domain/recipe.dart';
import '../features/recipes/presentation/home_page/home_page.dart';
import '../features/recipes/presentation/recipe_details/recipe_details_page.dart';
import '../providers/providers.dart';
import 'app_route.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      redirect: (context, state) {
        final user = firebaseAuth.currentUser;
        final isLoggedIn = user != null;
        print(user);
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
              ShellRoute(
                  builder: (context, state, child) {
                    return ScaffoldWithBottomNavBar(child: child);
                  },
                  routes: [
                    GoRoute(
                        path: 'home',
                        name: AppRoute.home.name,
                        pageBuilder: (context, state) {
                          return const MaterialPage(
                            child: HomePage(),
                          );
                        },
                        routes: [
                          GoRoute(
                            path: 'detail/:id',
                            name: AppRoute.detail.name,
                            builder: (context, state) {
                              final recipe = state.extra as Recipe;
                              return RecipeDetailsPage(recipe: recipe);
                            },
                          )
                        ]),
                  ]),
            ]),
      ]);
});
