import 'package:flutter_app2/spec/spec.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/actions/actions.dart';

main() {
  group('SwitchStateAction', () {
    test('invoke', () {
      ChangeScreensAction action = ChangeScreensAction(Screen.selecting_word_list);
      AppState currentState = AppState(Screen.word_list);
      AppState actioned = action.invoke(currentState);
      expect(actioned.screen, Screen.selecting_word_list);
    });

    test('toString', () {
      ChangeScreensAction action = ChangeScreensAction(Screen.selecting_word_list);
      expect(action.toString(), "SwitchStateAction{toSwitchTo: Screen.selecting_word_list}");
    });
  });

  group('ChapterSelectedAction', () {
    test('invoke', () {
      ChapterStructure chapterStructure = ChapterStructure();
      ChapterSpec ch4 = chapterStructure.applicationSpec.chapters[3];
      ChapterSelectedAction action = ChapterSelectedAction(3);
      AppState currentState = AppState(Screen.selecting_word_list);
      AppState updated = action.invoke(currentState);
      expect(updated.currentChapter, ch4);
    });

    test('selected', () {
      ChapterSelectedAction action = ChapterSelectedAction(3);
      expect(action.selected, 3);
    });

    test('toString', () {
      ChapterSelectedAction action = ChapterSelectedAction(2);
      expect(action.toString(), "ChapterSelectedAction{selected: 2}");
    });
  });
}