import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/actions/actions.dart';

main() {
  group('SwitchStateAction', () {
    test('constructor', () {
      ChangeScreensAction action = new ChangeScreensAction(Screen.selecting_word_list);
      expect(action.toSwitchTo, Screen.selecting_word_list);
    });
    test('toString', () {
      ChangeScreensAction action = new ChangeScreensAction(Screen.selecting_word_list);
      expect(action.toString(), "SwitchStateAction{toSwitchTo: Screen.selecting_word_list}");
    });
  });
}