import 'package:flutter_app2/models/app_state.dart';

abstract class StateSwitchAction {
  AppState invoke(AppState initialState);
}

//todo probably don't need this one!
class ChangeScreensAction extends StateSwitchAction {
  final Screen toSwitchTo;

  ChangeScreensAction(this.toSwitchTo);


  @override
  AppState invoke(AppState initialState) => initialState.copyWith(toSwitchTo);

  @override
  String toString() {
    return 'SwitchStateAction{toSwitchTo: $toSwitchTo}';
  }
}

class ChapterSelectedAction extends StateSwitchAction {
  final int selected;

  ChapterSelectedAction(this.selected);


  @override
  AppState invoke(AppState initialState) => initialState.copyWithChapter(selected);

  @override
  String toString() => 'ChapterSelectedAction{selected: $selected}';
}