import 'package:collection/collection.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/spec/spec.dart';
import 'package:flutter_app2/vocab/word.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  ChapterStructure chapterStructure = new ChapterStructure();
  ChapterSpec ch1 = chapterStructure.applicationSpec.chapters[0];
  ChapterSpec ch2 = chapterStructure.applicationSpec.chapters[1];
  WordListSpec wl1Ch1 = ch1.wordLists[0];
  WordListSpec wl2Ch1 = ch1.wordLists[1];
  WordListSpec wl1Ch2 = ch2.wordLists[0];
  WordListSpec wl2Ch2 = ch2.wordLists[1];
  ChapterState chState22 = ChapterState(ch2, wl2Ch2);
  WordState wordState3 = WordState(3, false);
  ListState shuffled = ListState(true, false);
  ListState straight = ListState(false, false);

  void checkThatStatesHaveDifferentWordTraversalOrderButShareWordsFromList(AppState stateA, AppState stateB, ChapterState chapterState) {
    int listSize = chapterState.currentWordList.wordList.words.length;
    //Record the words for stateA.
    List<Word> wordsA = [];
    for (int i=0; i<listSize; i++) {
      wordsA.add(stateA.currentWord);
      stateA = stateA.forNext().forNext();//Word and definition.
    }
    //Record the words for stateB.
    List<Word> wordsB = [];
    for (int i=0; i<listSize; i++) {
      wordsB.add(stateB.currentWord);
      stateB = stateB.forNext().forNext();//Word and definition.
    }
    //Check that the lists contain the same words.
    expect(wordsB.toSet(), wordsA.toSet());
    //Check that we have traversed all of the words.
    expect(chapterState.currentWordList.wordList.words.toSet(), wordsA.toSet());
    expect(ListEquality().equals(wordsB,wordsA), false);
  }

  void checkThatWordsAreInStraightOrder(AppState state, ChapterState chapterState) {
    var wordsStraight = chapterState.currentWordList.wordList.words;
    int listSize = wordsStraight.length;
    List<Word> words = [];
    for (int i=0; i<listSize; i++) {
      words.add(state.currentWord);
      state = state.forNext().forNext();//Word and definition.
    }
    expect(ListEquality().equals(wordsStraight,words), true);
  }

  group('constructors', () {
    test('default constructor', () {
      ChapterState chapterState = ChapterState(ch1, wl1Ch1);
      WordState wordState = WordState(3, false);
      AppState state = AppState(chapterState, wordState, true);
      expect(state.chapterState, chapterState);
      expect(state.wordState, wordState);
      ListState listState = ListState(true, false);
      expect(state.listState, listState);
    });

    test('initial', () {
      AppState state = AppState.initial();
      expect(state.chapterState, ChapterState(ch1, wl1Ch1));
      expect(state.wordState, WordState.initial());
      expect(state.listState, ListState.initial());
    });

    test('change chapter', () {
      AppState state0 = AppState(chState22, wordState3, true);
      AppState state1 = state0.forChapter(0);
      expect(state1.chapterState, ChapterState(ch1, wl1Ch1));
      expect(state1.wordState, WordState.initial());
      expect(state1.listState, shuffled);

      state0 = AppState(chState22, wordState3, false);
      state1 = state0.forChapter(0);
      expect(state1.chapterState, ChapterState(ch1, wl1Ch1));
      expect(state1.wordState, WordState.initial());
      expect(state1.listState, straight);//todo test that favourites is set to false.
    });

    test('change word list', () {
      AppState state0 = AppState(chState22, wordState3, true);
      AppState state1 = state0.forListInCurrentChapter(0);
      expect(state1.chapterState, ChapterState(ch2, wl1Ch2));
      expect(state1.wordState, WordState.initial());
      expect(state1.listState, shuffled);

      state0 = AppState(chState22, wordState3, false);
      state1 = state0.forListInCurrentChapter(0);
      expect(state1.chapterState, ChapterState(ch2, wl1Ch2));
      expect(state1.wordState, WordState.initial());
      expect(state1.listState, straight);
    });

    test('next', () {
      ChapterState chapterState = ChapterState(ch1, wl1Ch1);
      WordState wordState = WordState(3, false);
      ListState listState = ListState(false, false);
      AppState state = AppState(chapterState, wordState, false);
      AppState forNext = state.forNext();
      expect(forNext.chapterState, chapterState);
      expect(forNext.wordState, wordState.toggleShowDefinition());
      expect(forNext.listState, listState);//todo favourites
    });

    test('next limits', () {
      int listSize = wl1Ch1.wordList.words.length;
      ChapterState chapterState = ChapterState(ch1, wl1Ch1);
      for (int i = 0; i < listSize - 2; i++) {
        WordState wordState = WordState(i, false);
        AppState state = AppState(chapterState, wordState, false);
        AppState next = state.forNext();
        expect(next.wordState.index, i);
        expect(next.wordState.showDefinition, true);

        next = next.forNext();
        expect(next.wordState.index, i + 1);
        expect(next.wordState.showDefinition, false);

      }
      //At end, but still to display the definition.
      WordState wordState = WordState(listSize - 1, false);
      AppState state = AppState(chapterState, wordState, false);
      AppState next = state.forNext();
      expect(next.wordState.index, listSize - 1);
      expect(next.wordState.showDefinition, true);

      //Tip it over the edge.
      expect(next.atEndOfCurrentList, true);//sanity
      next = next.forNext();
      expect(next.wordState.index, 0);
      expect(next.wordState.showDefinition, false);
    });

    test('repeat', () {
      ChapterState chapterState = ChapterState(ch1, wl1Ch1);
      AppState state = AppState(chapterState, WordState(3, false), false);
      AppState repeated = state.forRepeat();
      expect(repeated.chapterState, chapterState);
      expect(repeated.wordState, WordState(0, false));
      expect(repeated.listState, straight);

      state = AppState(chapterState, WordState(5, true), false);
      repeated = state.forRepeat();
      expect(repeated.chapterState, chapterState);
      expect(repeated.wordState, WordState(0, false));
      expect(repeated.listState, straight);
    });

    test('repeat shuffled', () {
      ChapterState chapterState = ChapterState(ch1, wl1Ch1);
      int listSize = chapterState.currentWordList.wordList.words.length;
      AppState state = AppState(chapterState, WordState(listSize - 1, true), true);
      AppState repeated = state.forRepeat();
      expect(repeated.chapterState, chapterState);
      expect(repeated.wordState, WordState(0, false));
      expect(repeated.listState.shuffled, true);
      AppState twiceRepeated = repeated.forRepeat();
      checkThatStatesHaveDifferentWordTraversalOrderButShareWordsFromList(repeated, twiceRepeated, chapterState);
    });

    test('toggle shuffled from straight', () {
      ChapterState chapterState = ChapterState(ch1, wl1Ch1);
      int listSize = chapterState.currentWordList.wordList.words.length;
      AppState state = AppState(chapterState, WordState(listSize - 1, true), false);
      AppState toggledOnce = state.forToggleShuffle();
      expect(toggledOnce.chapterState, chapterState);
      expect(toggledOnce.wordState, WordState(0, false));
      expect(toggledOnce.listState.shuffled, true);
      checkThatStatesHaveDifferentWordTraversalOrderButShareWordsFromList(state, toggledOnce, chapterState);
      AppState toggledTwice = toggledOnce.forToggleShuffle();
      checkThatWordsAreInStraightOrder(toggledTwice, chapterState);
    });

    test('toggle shuffled from shuffled', () {
      ChapterState chapterState = ChapterState(ch1, wl1Ch1);
      AppState state = AppState(chapterState, WordState(0, false), true);
      AppState toggledOnce = state.forToggleShuffle();
      expect(toggledOnce.chapterState, chapterState);
      expect(toggledOnce.wordState, WordState(0, false));
      expect(toggledOnce.listState.shuffled, false);
      checkThatWordsAreInStraightOrder(toggledOnce, chapterState);
    });

    test('at end', () {
      int listSize = wl1Ch1.wordList.words.length;
      ChapterState chapterState = ChapterState(ch1, wl1Ch1);
      for (int i = 0; i < listSize - 2; i++) {
        WordState wordState = WordState(i, false);
        AppState state = AppState(chapterState, wordState, false);
        expect(state.atEndOfCurrentList, false);

        wordState = WordState(i, true);
        state = AppState(chapterState, wordState, false);
        expect(state.atEndOfCurrentList, false);
      }
      //At end, but still to display the definition.
      WordState wordState = WordState(listSize - 1, false);
      AppState state = AppState(chapterState, wordState, false);
      expect(state.atEndOfCurrentList, false);

      wordState = WordState(listSize - 1, true);
      state = AppState(chapterState, wordState, false);
      expect(state.atEndOfCurrentList, true);
    });

    test('current word list title', () {
      ChapterState chapterState = ChapterState(ch1, wl1Ch1);
      WordState wordState = WordState(3, false);
      AppState state = AppState(chapterState, wordState, false);
      expect(state.currentWordListTitle, wl1Ch1.title);
    });

    test('current chapter', () {
      ChapterState chapterState = ChapterState(ch1, wl1Ch1);
      WordState wordState = WordState(3, false);
      AppState state = AppState(chapterState, wordState, false);
      expect(state.currentChapter, ch1);
    });

    test('application spec', () {
      ChapterState chapterState = ChapterState(ch1, wl1Ch1);
      WordState wordState = WordState(3, false);
      AppState state = AppState(chapterState, wordState, false);
      expect(state.applicationSpec, chapterStructure.applicationSpec);
    });

    test('==', () {
      ChapterState cs11 = ChapterState(ch1, wl1Ch1);
      ChapterState cs21 = ChapterState(ch1, wl2Ch1);
      WordState ws1 = WordState(1, false);
      WordState ws2 = WordState(2, false);
      AppState appStateA = AppState(cs11, ws1, false);
      AppState appStateB = AppState(cs11, ws1, false);
      AppState appStateC = AppState(cs11, ws2, false);
      AppState appStateD = AppState(cs21, ws1, false);
      AppState appStateE = AppState(cs21, ws2, false);
      AppState appStateF = AppState(cs11, ws1, true);
      expect(appStateA == appStateB, true);
      expect(appStateA == appStateC, false);
      expect(appStateA == appStateD, false);
      expect(appStateA == appStateE, false);
      expect(appStateA == appStateF, false);
    });

    test('hashCode', () {
      ChapterState cs11 = ChapterState(ch1, wl1Ch1);
      WordState ws1 = WordState(1, false);
      AppState appStateA = AppState(cs11, ws1, true);
      AppState appStateB = AppState(cs11, ws1, true);
      expect(appStateA.hashCode, appStateB.hashCode);
    });
  });
}
