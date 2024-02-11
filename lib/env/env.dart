// lib/env/env.dart
import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: ".env")
abstract class Env {
  @EnviedField(varName: 'OPEN_AI_API_KEY') // the .env variable.
  static const dynamic apiKey = _Env.apiKey;
  @EnviedField(varName: 'PALM_KEY') // the .env variable.
  static const dynamic palmKey = _Env.palmKey;
}