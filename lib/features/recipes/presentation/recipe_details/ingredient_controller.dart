import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraction/fraction.dart';

import '../../../../providers/providers.dart';

sealed class Result<S, E extends Exception> {
  const Result();
}

final class Success<S, E extends Exception> extends Result<S, E> {
  const Success(this.value);
  final S value;
}

final class Failure<S, E extends Exception> extends Result<S, E> {
  const Failure(this.exception);
  final E exception;
}

final ingredientControllerProvider = StateProvider<IngredientController>((ref) {
  return IngredientController(ref: ref);
});

class IngredientController {
  IngredientController({
    required this.ref,
  });
  final Ref ref;

  Result<Rational, Exception> getCalculation(String quantity) {
    final multiplier = ref.read(ingredientMultiplierProvider);
    try {
      final type = Rational.tryParse(quantity).runtimeType;
      final Rational result;
      if (type == Fraction) {
        result = (quantity.toFraction().toDouble().toInt() * multiplier)
            .toFraction();
      } else if (type == MixedFraction) {
        result =
            (quantity.toMixedFraction().toDouble() * multiplier).toFraction();
      } else {
        result = (double.parse(quantity) * multiplier) % 1 == 0.0
            ? (double.parse(quantity) * multiplier).toInt().toFraction()
            : (double.parse(quantity) * multiplier).toFraction();
      }
      return Success(result);
    } on Exception catch (e) {
      if (e.runtimeType == FractionException) {
        final result =
            (quantity.toFraction().toDouble() * multiplier).toFraction();
        return Success(result);
      } else {
        return Failure(e);
      }
    }
  }
}
