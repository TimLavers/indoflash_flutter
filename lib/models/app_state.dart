//Adapted from https://github.com/brianegan/flutter_architecture_samples.git
import 'package:flutter_app2/spec/spec.dart';
import 'package:meta/meta.dart';

typedef void ChapterSelected(int index);
typedef void WordListSelected(int index);

@immutable
class AppState {
  final ChapterState chapterState;
  final WordState wordState;

  AppState(this.chapterState, this.wordState);

  AppState.forChapter(this.chapterState) : wordState = WordState(0, false);

  AppState toggle() => AppState(chapterState, wordState.toggleShowDefinition());

  AppState.forIndexedChapter(int index)
      : chapterState = ChapterState.withIndexedChapter(index),
        wordState = WordState(0, false);

  get currentWordList => chapterState.currentWordList;//todo test

//  get word {
//    return currentWordList[wordState.index].;
//  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              chapterState == other.chapterState &&
              wordState == other.wordState;

  @override
  int get hashCode =>
      chapterState.hashCode ^
      wordState.hashCode;
}

@immutable
class ChapterState {
  final applicationSpec = ChapterStructure().applicationSpec;
  final ChapterSpec currentChapter;
  final WordListSpec currentWordList;

  ChapterState.start()
      : currentChapter = ChapterStructure().chapter1,
        currentWordList = ChapterStructure().chapter1.wordLists[0];

  ChapterState.withIndexedChapter(int index)
      : currentChapter = ChapterStructure().applicationSpec.chapters[index],
        currentWordList = ChapterStructure().applicationSpec.chapters[index]
            .wordLists[0];

  ChapterState(this.currentChapter, this.currentWordList);

  ChapterState copyWithIndexedWordList(int wordListIndex) =>
      ChapterState(currentChapter, currentChapter.wordLists[wordListIndex]);

  @override
  int get hashCode => currentChapter.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ChapterState &&
              runtimeType == other.runtimeType &&
              currentWordList == other.currentWordList &&
              currentChapter == other.currentChapter;

  @override
  String toString() =>
      'AppState{chapter: ${currentChapter.title}}';
}

@immutable
class WordState {
  final int index;
  final bool showDefinition;

  WordState(this.index, this.showDefinition);

  WordState.withIndex(this.index) :showDefinition = false;

  WordState toggleShowDefinition() => WordState(index, !showDefinition);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is WordState &&
              runtimeType == other.runtimeType &&
              index == other.index &&
              showDefinition == other.showDefinition;

  @override
  int get hashCode =>
      index.hashCode ^
      showDefinition.hashCode;
}