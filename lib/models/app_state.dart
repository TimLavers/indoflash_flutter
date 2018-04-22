//Adapted from https://github.com/brianegan/flutter_architecture_samples.git
import 'package:flutter_app2/spec/spec.dart';
import 'package:meta/meta.dart';

enum Screen {
  word_list,
  selecting_word_list,
  selecting_chapter
}

typedef void ChapterSelected(int index);

@immutable
class AppState {
  final ApplicationSpec applicationSpec = new ChapterStructure()
      .applicationSpec;
  final Screen screen;
  final ChapterSpec currentChapter;

  AppState(this.screen) : currentChapter = new ChapterStructure().chapter1;

  AppState.copy(this.currentChapter, this.screen);

  AppState copyWith(Screen screen) => new AppState.copy(currentChapter, screen);

  AppState copyWithChapter(int chapterIndex) =>
      new AppState.copy(applicationSpec.chapters[chapterIndex], this.screen);

  @override
  int get hashCode => screen.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              currentChapter == other.currentChapter &&
              screen == other.screen;

  @override
  String toString() =>
      'AppState{screen: $screen, chapter: ${currentChapter.title}';
}