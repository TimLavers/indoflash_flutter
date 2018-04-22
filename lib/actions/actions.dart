import 'package:flutter_app2/models/app_state.dart';

abstract class StateSwitchAction {
  AppState invoke(AppState initialState);
}

//todo probably don't need this one!
class ChangeScreensAction extends StateSwitchAction {
  final Screen _toSwitchTo;

  ChangeScreensAction(this._toSwitchTo);

  @override
  AppState invoke(AppState initialState) => initialState.copyWith(_toSwitchTo);

  @override
  String toString() {
    return 'SwitchStateAction{toSwitchTo: $_toSwitchTo}';
  }
}

class ChapterSelectedAction extends StateSwitchAction {
  final int _selected;

  ChapterSelectedAction(this._selected);

  @override
  AppState invoke(AppState initialState) => initialState.copyWithChapter(_selected);

  @override
  String toString() => 'ChapterSelectedAction{selected: $_selected}';

  get selected => _selected;
}