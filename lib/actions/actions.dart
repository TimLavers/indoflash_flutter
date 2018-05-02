import 'package:flutter_app2/models/app_state.dart';

abstract class StateSwitchAction {
  AppState invoke(AppState initialState);
}

class ChapterSelectedAction extends StateSwitchAction {
  final int _selected;

  ChapterSelectedAction(this._selected);

  @override
  AppState invoke(AppState initialState) =>
      initialState.forChapter(_selected);

  @override
  String toString() => 'ChapterSelectedAction{selected: $_selected}';

  get selected => _selected;
}

class WordListSelectedAction extends StateSwitchAction {
  final int _selected;

  WordListSelectedAction(this._selected);

  @override
  AppState invoke(AppState initialState) =>
    initialState.forListInCurrentChapter(_selected);

  @override
  String toString() => 'WordListSelectedAction{selected: $_selected}';

  get selected => _selected;
}

class WordNext extends StateSwitchAction {

  @override
  AppState invoke(AppState initialState) => initialState.forNext();

  @override
  String toString() => 'WordNext';
}
class RepeatList extends StateSwitchAction {

  @override
  AppState invoke(AppState initialState) => initialState.forRepeat();

  @override
  String toString() => 'RepeatList';
}//todo test
class ToggleShuffle extends StateSwitchAction {

  @override
  AppState invoke(AppState initialState) => initialState.forRepeat();

  @override
  String toString() => 'ToggleShuffle';
}