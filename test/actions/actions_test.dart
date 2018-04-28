import 'package:flutter_app2/actions/actions.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/spec/spec.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  ChapterStructure chapterStructure = ChapterStructure();
  ChapterSpec ch1 = chapterStructure.applicationSpec.chapters[0];
  ChapterSpec ch4 = chapterStructure.applicationSpec.chapters[3];
  WordListSpec wl1 = ch1.wordLists[0];
  WordListSpec wl4 = ch1.wordLists[3];
  group('WordListSelectedAction', () {
    test('invoke', () {
      WordListSelectedAction action = WordListSelectedAction(3);
      AppState currentState = AppState.initial();
      expect(currentState.currentWordList, wl1);
      AppState updated = action.invoke(currentState);
      expect(updated.currentWordList, wl4);
    });

    test('selected', () {
      WordListSelectedAction action = WordListSelectedAction(3);
      expect(action.selected, 3);
    });

    test('toString', () {
      WordListSelectedAction action = WordListSelectedAction(2);
      expect(action.toString(), "WordListSelectedAction{selected: 2}");
    });
  });
  group('ChapterSelectedAction', () {
    test('invoke', () {
      ChapterSelectedAction action = ChapterSelectedAction(3);
      AppState currentState = AppState.initial();
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