//Adapted from https://github.com/brianegan/flutter_architecture_samples.git
import 'package:meta/meta.dart';
import 'package:flutter_app2/spec/spec.dart';

enum Screen {
  word_list, selecting_word_list, selecting_chapter
}

@immutable
class AppState {
  final ApplicationSpec applicationSpec = new ChapterStructure().applicationSpec;
  final Screen screen;
  final ChapterSpec currentChapter;

  AppState(this.screen) : currentChapter = new ChapterStructure().chapter1;

  AppState copyWith(Screen screen) {
    return new AppState.copy(currentChapter,screen);
  }

  AppState.copy(this.currentChapter, this.screen);

  @override
  int get hashCode => screen.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              screen == other.screen;

  @override
  String toString() {
    return 'AppState{screen: $screen}';
  }
}