import 'package:flutter/material.dart';
import 'package:flutter_app2/keys/keys.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/main_screen.dart';
import 'package:flutter_app2/vocab/word.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

import 'utils.dart';

void main() {
  group('MainScreenModel', () {
    final AppState initialState = new AppState.initial();
    AppState lastActionedState;

    AppState appReducer(AppState state, action) {
//      lastAction = action;
      lastActionedState = state;
      return state;
    }
    final store = Store<AppState>(
      appReducer,
      initialState: initialState,
    );

    test('listName', () {
      MainScreenModel model = MainScreenModel(store);
      expect(model.listName, initialState.chapterState.applicationSpec.chapters[0].wordLists[0].title);
    });

    test('index', () {
      MainScreenModel model = MainScreenModel(store);
      expect(model.index, 0);
    });
  });
}