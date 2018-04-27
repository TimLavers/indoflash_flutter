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

    test('toggle', () {
      ChapterState chapterState = ChapterState(ch1,wl1Ch1);
      WordState wordState = WordState(3, false);
      AppState state = AppState(chapterState, wordState);
      AppState toggled = state.toggle();
      expect(toggled.chapterState, chapterState);
      expect(toggled.wordState, wordState.toggleShowDefinition());
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