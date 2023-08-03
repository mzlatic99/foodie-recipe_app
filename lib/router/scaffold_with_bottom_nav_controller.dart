import 'package:flutter_riverpod/flutter_riverpod.dart';

final scaffoldBottomNavControllerProvider =
    StateNotifierProvider.autoDispose<ScaffoldWithBottomNavController, int>(
  (ref) => ScaffoldWithBottomNavController(0),
);

class ScaffoldWithBottomNavController extends StateNotifier<int> {
  ScaffoldWithBottomNavController(super.state);

  void setPosition(int value) {
    state = value;
  }
}
