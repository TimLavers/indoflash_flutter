import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/reducers/app_state_reducer.dart';
import 'package:flutter_app2/actions/actions.dart';

main() {
  group('appReducer', () {
    test('constructor empty', () {
      AppState state = AppState();
      StateSwitchAction action = new ChapterSelectedAction(3);
      var reduced = appReducer(state, action);
      expect(reduced.currentChapter, reduced.applicationSpec.chapters[3]);
    });
  });
}