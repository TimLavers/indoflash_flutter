import 'package:flutter_app2/models/app_state.dart';

abstract class StateSwitchAction {
  AppState invoke(AppState initialState);
}

class ChapterSelectedAction extends StateSwitchAction {
  final int _selected;

  ChapterSelectedAction(this._selected);

  @override
  AppState invoke(AppState initialState) => initialState.copyWithIndexedChapter(_selected);

  @override
  String toString() => 'ChapterSelectedAction{selected: $_selected}';

  get selected => _selected;
}
class WordListSelectedAction extends StateSwitchAction {
  final int _selected;

  WordListSelectedAction(this._selected);

  @override
  AppState invoke(AppState initialState) => initialState.copyWithIndexedWordList(_selected);

  @override
  String toString() => 'WordListSelectedAction{selected: $_selected}';

  get selected => _selected;
}