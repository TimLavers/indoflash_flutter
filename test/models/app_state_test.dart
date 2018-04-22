import 'package:flutter_app2/spec/spec.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app2/models/app_state.dart';

main() {
  ChapterStructure chapterStructure = new ChapterStructure();
  ChapterSpec ch1 = chapterStructure.applicationSpec.chapters[0];
  ChapterSpec ch2 = chapterStructure.applicationSpec.chapters[1];
  ChapterSpec ch4 = chapterStructure.applicationSpec.chapters[3];
  group('constructors', () {
    test('constructor from screen', () {
      AppState state = new AppState(Screen.word_list);
      expect(state.screen, Screen.word_list);
      expect(state.currentChapter, ch1);
    });

    test('copy', () {
      AppState state = new AppState.copy(ch2, Screen.selecting_word_list);
      expect(state.screen, Screen.selecting_word_list);
      expect(state.currentChapter, ch2);
    });

    test('copy with screen', () {
      AppState state = new AppState.copy(ch2, Screen.selecting_word_list);
      var copyWith = state.copyWith(Screen.word_list);
      expect(copyWith.screen, Screen.word_list);
      expect(copyWith.currentChapter, ch2);
      var copyAgain = state.copyWith(Screen.selecting_chapter);
      expect(copyAgain.screen, Screen.selecting_chapter);
      expect(copyAgain.currentChapter, ch2);
    });

    test('copy with chapter', () {
      AppState state = new AppState.copy(ch2, Screen.selecting_word_list);
      var copyWith = state.copyWithChapter(3);
      expect(copyWith.screen, Screen.selecting_word_list);
      expect(copyWith.currentChapter, ch4);
      var copyAgain = state.copyWithChapter(0);
      expect(copyAgain.screen, Screen.selecting_word_list);
      expect(copyAgain.currentChapter, ch1);
    });

    test('==', () {
      AppState selectingChapterA = new AppState(Screen.selecting_chapter);
      AppState selectingChapterB = new AppState(Screen.selecting_chapter);
      AppState selectingWordlistChapter1 = new AppState(Screen.selecting_word_list);
      AppState selectingWordlistChapter2A = new AppState.copy(ch2, Screen.selecting_word_list);
      AppState selectingWordlistChapter2B = new AppState.copy(ch2, Screen.selecting_word_list);
      expect(selectingChapterA == selectingChapterB, true);
      expect(selectingChapterA == selectingWordlistChapter1, false);
      expect(selectingWordlistChapter1 == selectingWordlistChapter2A, false);
      expect(selectingWordlistChapter2B == selectingWordlistChapter2A, true);
    });

    test('hashCode', () {
      AppState state1 = new AppState.copy(ch2, Screen.selecting_word_list);
      AppState state2 = new AppState.copy(ch2, Screen.selecting_word_list);
      expect(state1.hashCode, state2.hashCode);
    });

    test('toString', () {
      AppState state1 = new AppState.copy(ch2, Screen.selecting_word_list);
      expect(state1.toString().contains(Screen.selecting_word_list.toString()), true);
      expect(state1.toString().contains(ch2.title.toString()), true);
    });
  });
}