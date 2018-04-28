import 'package:flutter_app2/actions/actions.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/chapter_selector.dart';
import 'package:flutter_app2/spec/spec.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

void main() {
  ChapterStructure chapterStructure = new ChapterStructure();
  ChapterSelectedAction lastAction;
  AppState lastActionedState;
  final AppState initialState = new AppState.initial();
  AppState appReducer(AppState state, action) {
    lastAction = action;
    lastActionedState = state;
    return state;
  }
  final store = new Store<AppState>(
    appReducer,
    initialState: initialState,
  );
  ChaptersModel model = new ChaptersModel(store);
  group('ChaptersModel', () {
    test('length', () {
      expect(model.length, chapterStructure.applicationSpec.chapters.length);
    });
    test('chapter title', () {
      ChapterSpec ch4 = chapterStructure.applicationSpec.chapters[3];
      expect(model.title(3), ch4.title);
    });
    test('chapter selected', () {
      model.chapterSelected(4);
      expect(lastAction.selected, 4);
      expect(lastActionedState, initialState);
    });
  });
}