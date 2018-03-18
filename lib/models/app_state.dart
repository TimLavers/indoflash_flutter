//Adapted from https://github.com/brianegan/flutter_architecture_samples.git
import 'package:meta/meta.dart';

enum Screen {
  word_list, selecting_word_list, selecting_chapter
}

@immutable
class AppState {
  final Screen screen;

  AppState({this.screen = Screen.word_list});

  factory AppState.showingWordList() => new AppState(screen: Screen.word_list);

  AppState copyWith({Screen screen}) {
    return new AppState(screen: screen);
  }

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