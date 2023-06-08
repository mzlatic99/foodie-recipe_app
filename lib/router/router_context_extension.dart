import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/recipes/domain/recipe.dart';
import 'app_route.dart';

/// Extension on [BuildContext] to simplify navigation
extension RouterContextExtension on BuildContext {
  void pop() {
    GoRouter.of(this).pop();
  }

  void goHome(
      //Map<String, String> queryParameters = const <String, String>{},
      //Object? extra,
      ) {
    GoRouter.of(this).pushNamed(
      AppRoute.home.name,
      //queryParameters: queryParameters,
      //extra: extra,
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

  void replaceHome({
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
  }) {
    GoRouter.of(this).replaceNamed(
      AppRoute.home.name,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  void pushDetailPage({
    required Recipe recipe,
  }) =>
      GoRouter.of(this).pushNamed(
        AppRoute.detail.name,
        extra: recipe,
        pathParameters: {'id': '${recipe.id}'},
      );
}
