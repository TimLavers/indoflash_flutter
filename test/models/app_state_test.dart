import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app2/models/app_state.dart';

main() {
  group('Constructors and factories', () {
//    test('constructor empty', () {
//      AppState state = new AppState();
//      expect(state.screen, Screen.word_list);
//    });

    test('constructor with screen', () {
      AppState state = new AppState(null, Screen.selecting_chapter);
      expect(state.screen, Screen.selecting_chapter);
    });
/*
    test('showingWordList', () {
      AppState state = new AppState.showingWordList();
      expect(state.screen, Screen.word_list);
    });
  });

  group('copier', () {
    test('copyWith', () {
      AppState state = new AppState.showingWordList();
      var copyWith = state.copyWith(screen: Screen.selecting_word_list);
      expect(copyWith.screen, Screen.selecting_word_list);
    });
  });

  group('standard', () {
    test('==', () {
      AppState selectingChapter0 = new AppState(screen: Screen.selecting_chapter);
      AppState selectingChapter1 = new AppState(screen: Screen.selecting_chapter);
      AppState selectingWordlist = new AppState(screen: Screen.selecting_word_list);
      AppState wordList = new AppState(screen: Screen.word_list);
      expect(selectingChapter0 == selectingChapter0, true);
      expect(selectingChapter0 == selectingChapter1, true);
      expect(selectingChapter0 == selectingWordlist, false);
      expect(selectingWordlist == wordList, false);
    });

    test('hashCode', () {
      AppState selectingChapter0 = new AppState(screen: Screen.selecting_chapter);
      AppState selectingChapter1 = new AppState(screen: Screen.selecting_chapter);
      expect(selectingChapter0.hashCode, selectingChapter1.hashCode);
    });

    test('toString', () {
      AppState selectingChapter = new AppState(screen: Screen.selecting_chapter);
      expect(selectingChapter.toString(), 'AppState{screen: Screen.selecting_chapter}');
    });
  });
*/
  });
}