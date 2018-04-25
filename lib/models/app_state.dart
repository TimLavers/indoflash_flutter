//Adapted from https://github.com/brianegan/flutter_architecture_samples.git
import 'package:flutter_app2/spec/spec.dart';
import 'package:meta/meta.dart';

enum Screen {
  word_list,
  selecting_word_list,
  selecting_chapter
}

typedef void ChapterSelected(int index);
typedef void WordListSelected(int index);

@immutable
class AppState {
  final ApplicationSpec applicationSpec = new ChapterStructure()
      .applicationSpec;
  final Screen screen;
  final ChapterSpec currentChapter;
  final WordListSpec currentWordList;

  AppState(this.screen) : currentChapter = new ChapterStructure().chapter1, currentWordList = new ChapterStructure().chapter1.wordLists[0];

  AppState.copyWithChapter(this.currentChapter, this.screen) : currentWordList = currentChapter.wordLists[0];

  AppState.copy(this.currentChapter, this.currentWordList, this.screen);

  AppState copyWith(Screen screen) => new AppState.copy(currentChapter, currentWordList, screen);

  AppState copyWithIndexedChapter(int chapterIndex) =>
      new AppState.copyWithChapter(applicationSpec.chapters[chapterIndex], this.screen);

  AppState copyWithIndexedWordList(int wordListIndex) =>
      AppState.copy(currentChapter, currentChapter.wordLists[wordListIndex], this.screen);

  @override
  int get hashCode => screen.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              currentWordList == other.currentWordList &&
              currentChapter == other.currentChapter &&
              screen == other.screen;

  @override
  String toString() =>
      'AppState{screen: $screen, chapter: ${currentChapter.title}';
}