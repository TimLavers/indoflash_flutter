// Adapted from The Flutter Architecture Sample.
// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

library integration_tests;

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../integration_tests/screens/main_screen.dart';

main() {
  group('Indo Flash Integration Tests', () {
    FlutterDriver driver;
    MainScreen homeScreen;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      homeScreen = new MainScreen(driver);
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('initial state', () async {
      expect(await homeScreen.currentWord, 'anda');
      expect(await homeScreen.currentDefinition, '');
    });
  });
}

