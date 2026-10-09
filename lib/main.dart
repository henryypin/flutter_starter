import 'package:flutter_starter/app/bootstrap.dart';
import 'package:flutter_starter/app/config/app_config.dart';

Future<void> main() async {
  await bootstrap(AppConfig.fromEnvironment());
}
