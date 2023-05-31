import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/recipes/domain/recipe.dart';
import 'route_names.dart';

/// Extension on [BuildContext] to simplify navigation
extension RouterContextExtension on BuildContext {
  void pop() {
    GoRouter.of(this).pop();
  }

  void goHome({
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
  }) {
    GoRouter.of(this).goNamed(
      RouteNames.home,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  void replaceHome({
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
  }) {
    GoRouter.of(this).replaceNamed(
      RouteNames.home,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  void pushDetailPage({
    required Recipe recipe,
  }) =>
      GoRouter.of(this).pushNamed(
        RouteNames.detail,
        extra: recipe,
        pathParameters: {'id': '${recipe.id}'},
      );
}
