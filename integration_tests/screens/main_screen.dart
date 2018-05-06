import 'dart:async';

import 'package:flutter_driver/flutter_driver.dart';

import 'test_screen.dart';
//import '../../lib/keys/keys.dart';


class MainScreen extends TestScreen {
  final _listNavigationButton = find.byValueKey('__navigate_list_button__');
  final _indonesianFirstToggleButton = find.byValueKey('__indonesian_first_toggle_button__');
  final _wordArea = find.byValueKey('__word__');
  final _definitionArea = find.byValueKey('__definition__');

  MainScreen(FlutterDriver driver) : super(driver);

  Future<String> get currentWord => driver.getText(_wordArea);

  Future<String> get currentDefinition => driver.getText(_definitionArea);

  Future<Null> tapNavigationButton() async {
    await driver.tap(_listNavigationButton);
  }

  Future<Null> tapIndonesianFirstToggleButton() async {
    await driver.tap(_indonesianFirstToggleButton);
  }
}
