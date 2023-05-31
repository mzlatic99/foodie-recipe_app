import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'TASTY_KEY', obfuscate: true)
  static final String tastyApiKey = _Env.tastyApiKey;
}
