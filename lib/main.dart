import 'package:flutter/cupertino.dart';
import 'package:pokedex/app/app.dart';
import 'package:pokedex/app/config/locator_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}
