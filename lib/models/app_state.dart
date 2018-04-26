//Adapted from https://github.com/brianegan/flutter_architecture_samples.git
import 'package:flutter_app2/spec/spec.dart';
import 'package:meta/meta.dart';

typedef void ChapterSelected(int index);
typedef void WordListSelected(int index);

@immutable
class AppState {
  final applicationSpec = ChapterStructure().applicationSpec;
  final ChapterSpec currentChapter;
  final WordListSpec currentWordList;

  AppState() : currentChapter = ChapterStructure().chapter1, currentWordList = ChapterStructure().chapter1.wordLists[0];

  AppState.copyWithChapter(this.currentChapter) : currentWordList = currentChapter.wordLists[0];

  AppState.copy(this.currentChapter, this.currentWordList);

  AppState copyWith() => AppState.copy(currentChapter, currentWordList);

  AppState copyWithIndexedChapter(int chapterIndex) =>
      AppState.copyWithChapter(applicationSpec.chapters[chapterIndex]);

  AppState copyWithIndexedWordList(int wordListIndex) =>
      AppState.copy(currentChapter, currentChapter.wordLists[wordListIndex]);

  @override
  int get hashCode => currentChapter.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              currentWordList == other.currentWordList &&
              currentChapter == other.currentChapter;

  @override
  String toString() =>
      'AppState{chapter: ${currentChapter.title}}';
}