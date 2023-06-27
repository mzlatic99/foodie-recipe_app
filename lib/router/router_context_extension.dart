import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/recipes/domain/recipe.dart';
import 'app_route.dart';

/// Extension on [BuildContext] to simplify navigation
extension RouterContextExtension on BuildContext {
  void pop() {
    GoRouter.of(this).pop();
  }

  String currentLocation() {
    return GoRouter.of(this).location;
  }

  void goHome() {
    GoRouter.of(this).goNamed(
      AppRoute.home.name,
    );
  }

  void goLogIn() {
    GoRouter.of(this).pushNamed(
      AppRoute.login.name,
    );
  }

  void goSignUp() {
    GoRouter.of(this).pushNamed(
      AppRoute.signup.name,
    );
  }

  void pushStepsPage({
    required Recipe recipe,
  }) =>
      GoRouter.of(this).pushNamed(
        AppRoute.steps.name,
        extra: recipe,
        pathParameters: {'id': '${recipe.id}'},
      );

  void pushDetailPage({
    required Recipe recipe,
  }) =>
      GoRouter.of(this).pushNamed(
        AppRoute.detail.name,
        extra: recipe,
        pathParameters: {'id': '${recipe.id}'},
      );

  void goSavedRecipes() {
    GoRouter.of(this).goNamed(
      AppRoute.saved.name,
    );
  }
}
