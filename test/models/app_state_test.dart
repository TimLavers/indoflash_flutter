import 'package:flutter_app2/spec/spec.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app2/models/app_state.dart';

main() {
  ChapterStructure chapterStructure = new ChapterStructure();
  ChapterSpec ch1 = chapterStructure.applicationSpec.chapters[0];
  WordListSpec wl1Ch1 = ch1.wordLists[0];
  WordListSpec wl2Ch1 = ch1.wordLists[1];

  group('constructors', () {
    test('empty constructor', () {
      ChapterState chapterState = ChapterState(ch1,wl1Ch1);
      WordState wordState = WordState(3, false);
      AppState state = AppState(chapterState, wordState);
      expect(state.chapterState, chapterState);
      expect(state.wordState, wordState);
    });

    test('initial', () {
      AppState state = AppState.initial();
      expect(state.chapterState, ChapterState(ch1, wl1Ch1));
      expect(state.wordState, WordState.initial());
    });

    test('forNext', () {
      ChapterState chapterState = ChapterState(ch1,wl1Ch1);
      WordState wordState = WordState(3, false);
      AppState state = AppState(chapterState, wordState);
      AppState toggled = state.forNext();
      expect(toggled.chapterState, chapterState);
      expect(toggled.wordState, wordState.toggleShowDefinition());
    });

    test('repeat', () {
      ChapterState chapterState = ChapterState(ch1,wl1Ch1);
      AppState state = AppState(chapterState, WordState(3, false));
      AppState repeated = state.forRepeat();
      expect(repeated.chapterState, chapterState);
      expect(repeated.wordState, WordState(0, false));

      state = AppState(chapterState, WordState(5, true));
      repeated = state.forRepeat();
      expect(repeated.chapterState, chapterState);
      expect(repeated.wordState, WordState(0, false));
    });

    test('at end', () {
      int listSize = wl1Ch1.wordList.words.length;
      ChapterState chapterState = ChapterState(ch1,wl1Ch1);
      for (int i=0; i<listSize-2; i++) {
        WordState wordState = WordState(i, false);
        AppState state = AppState(chapterState, wordState);
        expect(state.atEndOfCurrentList, false);

        wordState = WordState(i, true);
        state = AppState(chapterState, wordState);
        expect(state.atEndOfCurrentList, false);
      }
      //At end, but still to display the definition.
      WordState wordState = WordState(listSize-1, false);
      AppState state = AppState(chapterState, wordState);
      expect(state.atEndOfCurrentList, false);

      wordState = WordState(listSize-1, true);
      state = AppState(chapterState, wordState);
      expect(state.atEndOfCurrentList, true);
    });

    test('current word list', () {
      ChapterState chapterState = ChapterState(ch1,wl1Ch1);
      WordState wordState = WordState(3, false);
      AppState state = AppState(chapterState, wordState);
      expect(state.currentWordList, wl1Ch1);
    });

    test('current chapter', () {
      ChapterState chapterState = ChapterState(ch1,wl1Ch1);
      WordState wordState = WordState(3, false);
      AppState state = AppState(chapterState, wordState);
      expect(state.currentChapter, ch1);
    });

    test('application spec', () {
      ChapterState chapterState = ChapterState(ch1,wl1Ch1);
      WordState wordState = WordState(3, false);
      AppState state = AppState(chapterState, wordState);
      expect(state.applicationSpec, chapterStructure.applicationSpec);
    });

    test('for chapter', () {
      ChapterState chapterState = ChapterState(ch1,wl1Ch1);
      AppState state = new AppState.forChapter(chapterState);
      expect(state.chapterState, chapterState);
      expect(state.wordState, WordState(0, false));
    });

    test('==', () {
      ChapterState cs11 = ChapterState(ch1,wl1Ch1);
      ChapterState cs21 = ChapterState(ch1,wl2Ch1);
      WordState ws1 = WordState(1, false);
      WordState ws2 = WordState(2, false);
      AppState appStateA = AppState(cs11, ws1);
      AppState appStateB = AppState(cs11, ws1);
      AppState appStateC = AppState(cs11, ws2);
      AppState appStateD = AppState(cs21, ws1);
      AppState appStateE = AppState(cs21, ws2);
      expect(appStateA == appStateB, true);
      expect(appStateA == appStateC, false);
      expect(appStateA == appStateD, false);
      expect(appStateA == appStateE, false);
    });

    test('hashCode', () {
      ChapterState cs11 = ChapterState(ch1,wl1Ch1);
      WordState ws1 = WordState(1, false);
      AppState appStateA = AppState(cs11, ws1);
      AppState appStateB = AppState(cs11, ws1);
      expect(appStateA.hashCode, appStateB.hashCode);
    });
  });
}