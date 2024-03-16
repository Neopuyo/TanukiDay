// ignore_for_file: constant_identifier_names

import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
abstract class Env{
  @EnviedField(varName: 'GITHUB_AUTH_URL',obfuscate: true)
  static String githubAuthUrl=_Env.githubAuthUrl;

  @EnviedField(varName: 'GITHUB_CLIENT_ID',obfuscate: true)
  static String githubClientId=_Env.githubClientId;

  @EnviedField(varName: 'GITHUB_SECRET_KEY',obfuscate: true)
  static String githubSecretKey=_Env.githubSecretKey;
}