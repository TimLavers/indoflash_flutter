import 'package:flutter_app2/spec/spec.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app2/models/app_state.dart';

main() {
  ChapterStructure chapterStructure = new ChapterStructure();
  ChapterSpec ch1 = chapterStructure.applicationSpec.chapters[0];
  WordListSpec wl1Ch1 = ch1.wordLists[0];
  ChapterSpec ch2 = chapterStructure.applicationSpec.chapters[1];
  WordListSpec wl1Ch2 = ch2.wordLists[0];
  WordListSpec wl2Ch2 = ch2.wordLists[1];
  ChapterSpec ch4 = chapterStructure.applicationSpec.chapters[3];
  WordListSpec wl1Ch4 = ch4.wordLists[0];
  group('ChapterState', () {
    test('start', () {
      ChapterState state = new ChapterState.start();
      expect(state.currentChapter, ch1);
    });

    test('constructor', () {
      ChapterState state = new ChapterState(ch2, wl2Ch2);
      expect(state.currentChapter, ch2);
      expect(state.currentWordList, wl2Ch2);
    });

    test('withIndexedChapter', () {
      var copyWith = ChapterState.withIndexedChapter(3);
      expect(copyWith.currentChapter, ch4);
      expect(copyWith.currentWordList, wl1Ch4);
    });

    test('copyWithIndexedWordList', () {
      ChapterState state = ChapterState(ch2, wl2Ch2);
      var copyWith = state.copyWithIndexedWordList(0);
      expect(copyWith.currentChapter, ch2);
      expect(copyWith.currentWordList, wl1Ch2);
    });

    test('==', () {
      ChapterState selectingChapterA = new ChapterState.start();
      ChapterState selectingChapterB = new ChapterState.start();
      ChapterState selectingWordlistChapter2AWL1 = new ChapterState(ch2, wl1Ch2);
      ChapterState selectingWordlistChapter2AWL2 = new ChapterState(ch2, wl2Ch2);
      ChapterState selectingWordlistChapter2BWL1 = new ChapterState(ch2, wl1Ch2);
      ChapterState selectingWordlistChapter2BWL2 = new ChapterState(ch2, wl2Ch2);
      expect(selectingChapterA == selectingChapterB, true);
      expect(selectingWordlistChapter2BWL1 == selectingWordlistChapter2AWL1, true);
      expect(selectingWordlistChapter2BWL1 == selectingWordlistChapter2AWL2, false);
      expect(selectingWordlistChapter2BWL2 == selectingWordlistChapter2AWL2, true);
    });

    test('hashCode', () {
      ChapterState state1 = new ChapterState(ch2, wl2Ch2);
      ChapterState state2 = new ChapterState(ch2, wl2Ch2);
      expect(state1.hashCode, state2.hashCode);
    });

    test('toString', () {
      ChapterState state1 = new ChapterState(ch2, wl2Ch2);
      expect(state1.toString().contains(ch2.title.toString()), true);
    });
  });
}