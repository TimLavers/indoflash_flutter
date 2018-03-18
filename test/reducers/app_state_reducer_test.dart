import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/reducers/app_state_reducer.dart';

main() {
  group('appReducer', () {
    test('constructor empty', () {
      AppState state = new AppState();
      var reduced = appReducer(state, Screen.selecting_word_list);
      expect(reduced.screen, Screen.selecting_word_list);
    });
  });
}