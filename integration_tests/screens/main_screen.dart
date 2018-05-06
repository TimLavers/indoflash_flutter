import 'package:flutter_driver/flutter_driver.dart';
import 'dart:async';
//import '../../lib/keys/keys.dart';
import 'test_screen.dart';

class MainScreen extends TestScreen {
//  final _listNavigationButton = find.byValueKey(navigateListButtonKey);
  final _wordArea = find.byValueKey('__word__');
  final _definitionArea = find.byValueKey('__definition__');

  MainScreen(FlutterDriver driver) : super(driver);

  Future<String> get currentWord => driver.getText(_wordArea);

  Future<String> get currentDefinition => driver.getText(_definitionArea);
}
