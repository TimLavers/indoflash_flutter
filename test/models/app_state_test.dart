import 'package:flutter_app2/spec/spec.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app2/models/app_state.dart';

main() {
  ChapterStructure chapterStructure = new ChapterStructure();
  ChapterSpec ch1 = chapterStructure.applicationSpec.chapters[0];
  WordListSpec wl1Ch1 = ch1.wordLists[0];
  WordListSpec wl2Ch1 = ch1.wordLists[1];
  ChapterSpec ch2 = chapterStructure.applicationSpec.chapters[1];
  WordListSpec wl1Ch2 = ch2.wordLists[0];
  WordListSpec wl2Ch2 = ch2.wordLists[1];
  ChapterSpec ch4 = chapterStructure.applicationSpec.chapters[3];
  WordListSpec wl1Ch4 = ch4.wordLists[0];
  WordListSpec wl2Ch4 = ch4.wordLists[1];
  group('constructors', () {
    test('empty constructor', () {
      AppState state = new AppState();
      expect(state.currentChapter, ch1);
    });

    test('copy', () {
      AppState state = new AppState.copy(ch2, wl1Ch2);
      expect(state.currentChapter, ch2);
      expect(state.currentWordList, wl1Ch2);
    });

    test('copy with', () {
      AppState state = new AppState.copy(ch2, wl2Ch2);
      var copyWith = state.copyWith();
      expect(copyWith.currentChapter, ch2);
      expect(state.currentWordList, wl2Ch2);
      var copyAgain = state.copyWith();
      expect(copyAgain.currentChapter, ch2);
      expect(state.currentWordList, wl2Ch2);
    });

    test('copy with chapter', () {
      AppState state = AppState.copy(ch2, wl2Ch2);
      var copyWith = state.copyWithIndexedChapter(3);
      expect(copyWith.currentChapter, ch4);
      expect(copyWith.currentWordList, wl1Ch4);
      var copyAgain = state.copyWithIndexedChapter(0);
      expect(copyAgain.currentChapter, ch1);
      expect(copyAgain.currentWordList, wl1Ch1);
    });

    test('==', () {
      AppState selectingChapterA = new AppState();
      AppState selectingChapterB = new AppState();
      AppState selectingWordlistChapter2AWL1 = new AppState.copy(ch2, wl1Ch2);
      AppState selectingWordlistChapter2AWL2 = new AppState.copy(ch2, wl2Ch2);
      AppState selectingWordlistChapter2BWL1 = new AppState.copy(ch2, wl1Ch2);
      AppState selectingWordlistChapter2BWL2 = new AppState.copy(ch2, wl2Ch2);
      expect(selectingChapterA == selectingChapterB, true);
      expect(selectingWordlistChapter2BWL1 == selectingWordlistChapter2AWL1, true);
      expect(selectingWordlistChapter2BWL1 == selectingWordlistChapter2AWL2, false);
      expect(selectingWordlistChapter2BWL2 == selectingWordlistChapter2AWL2, true);
    });

    test('hashCode', () {
      AppState state1 = new AppState.copy(ch2, wl2Ch2);
      AppState state2 = new AppState.copy(ch2, wl2Ch2);
      expect(state1.hashCode, state2.hashCode);
    });

    test('toString', () {
      AppState state1 = new AppState.copy(ch2, wl2Ch2);
      expect(state1.toString().contains(ch2.title.toString()), true);
    });
  });
}