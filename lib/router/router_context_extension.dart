import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/recipes/domain/recipe.dart';
import 'app_route.dart';

extension RouterContextExtension on BuildContext {
  String currentLocation() {
    return GoRouter.of(this).location;
  }

  void goHome() {
    GoRouter.of(this).goNamed(
      AppRoute.home.name,
    );
  }

  void goChallenges() {
    GoRouter.of(this).goNamed(
      AppRoute.challenges.name,
    );
  }

  void pushChallenges() {
    GoRouter.of(this).pushNamed(
      AppRoute.challenges.name,
    );
  }

  void goSaved() {
    GoRouter.of(this).goNamed(
      AppRoute.saved.name,
    );
  }

  void pushSaved() {
    GoRouter.of(this).pushNamed(
      AppRoute.saved.name,
    );
  }

  void goFriends() {
    GoRouter.of(this).goNamed(
      AppRoute.friends.name,
    );
  }

  void pushFriends() {
    GoRouter.of(this).pushNamed(
      AppRoute.friends.name,
    );
  }

  void goProfile() {
    GoRouter.of(this).goNamed(
      AppRoute.profile.name,
    );
  }

  void pushProfile() {
    GoRouter.of(this).pushNamed(
      AppRoute.profile.name,
    );
  }

  void pushHome() {
    GoRouter.of(this).pushNamed(
      AppRoute.home.name,
    );
  }

  void pushOnboarding() {
    GoRouter.of(this).pushNamed(
      AppRoute.onboarding.name,
    );
  }

  void signOutAndPop() {
    GoRouter.of(this).pushNamed(AppRoute.onboarding.name);
  }

  void pushOnboardingAndRemoveUntil() {
    GoRouter.of(this).pushReplacementNamed(AppRoute.onboarding.name);
  }

  void goLogIn() {
    GoRouter.of(this).goNamed(
      AppRoute.login.name,
    );
  }

  void pushLogIn() {
    GoRouter.of(this).pushNamed(
      AppRoute.login.name,
    );
  }

  void goSignUp() {
    GoRouter.of(this).goNamed(
      AppRoute.signup.name,
    );
  }

  void pushSignUp() {
    GoRouter.of(this).pushNamed(
      AppRoute.signup.name,
    );
  }

  void pushAddFriendPage() {
    GoRouter.of(this).pushNamed(
      AppRoute.addfriend.name,
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

  void pushChatPage({required String id, required String name}) =>
      GoRouter.of(this).goNamed(AppRoute.chat.name, extra: {
        'id': id,
        'name': name,
      }, pathParameters: {
        'id': name
      });
}
