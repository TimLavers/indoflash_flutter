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
    MainScreen mainScreen;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      mainScreen = MainScreen(driver);
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('next word', () async {
      expect(await mainScreen.currentWord, 'anda');
      expect(await mainScreen.currentDefinition, '');
      await mainScreen.tapNavigationButton();
      expect(await mainScreen.currentWord, 'anda');
      expect(await mainScreen.currentDefinition, 'you');

      await mainScreen.tapNavigationButton();
      expect(await mainScreen.currentWord, 'apa');
      expect(await mainScreen.currentDefinition, '');
      await mainScreen.tapNavigationButton();
      expect(await mainScreen.currentWord, 'apa');
      expect(await mainScreen.currentDefinition, 'what');
    });
    
    test('repeat list when finished', () async {
      //There are 24 words in the first list. Go through the first 23.
      for (int i=0; i<22; i++) {
        await mainScreen.tapNavigationButton();
        await mainScreen.tapNavigationButton();
      }
      //Sanity check that we are on the last word of the list.
      expect(await mainScreen.currentWord, 'terima kasih');
      expect(await mainScreen.currentDefinition, 'thank you');

      //If we activate the next button we should get back to the start.
      await mainScreen.tapNavigationButton();

      expect(await mainScreen.currentWord, 'anda');
      expect(await mainScreen.currentDefinition, '');
      await mainScreen.tapNavigationButton();
      expect(await mainScreen.currentWord, 'anda');
      expect(await mainScreen.currentDefinition, 'you');
    });

    test('toggle show indonesian first', () async {
      //Sanity check that word1 of list1 of chapter1 is showing.
      expect(await mainScreen.currentWord, 'anda');

      await mainScreen.tapIndonesianFirstToggleButton();

      //The translation should now be showing as the word.
      expect(await mainScreen.currentWord, 'you');
      expect(await mainScreen.currentDefinition, '');

      //Navigate through the list and check that English is in the
      //word box and the Indonesian translation is in the definition
      //box.
      await mainScreen.tapNavigationButton();
      expect(await mainScreen.currentWord, 'you');
      expect(await mainScreen.currentDefinition, 'anda');
      await mainScreen.tapNavigationButton();
      await mainScreen.tapNavigationButton();
      expect(await mainScreen.currentWord, 'what');
      expect(await mainScreen.currentDefinition, 'apa');
    });
  });
}

