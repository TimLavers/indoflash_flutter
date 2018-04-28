import 'package:flutter_app2/actions/actions.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/word_list_selector.dart';
import 'package:flutter_app2/spec/spec.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

void main() {
  final ChapterStructure chapterStructure = ChapterStructure();
  final chapters = chapterStructure.applicationSpec.chapters;
  final chapter1 = chapters[0];
  final AppState initialState = new AppState.initial();
  WordListSelectedAction lastAction;
  AppState lastActionedState;
  AppState appReducer(AppState state, action) {
    lastAction = action;
    lastActionedState = state;
    return state;
  }
  final store = new Store<AppState>(
    appReducer,
    initialState: initialState,
  );
  WordListsModel model = new WordListsModel(store);
  group('WordListsModel', () {
    test('length', () {
      expect(model.length, chapter1.wordLists.length);
    });
    test('title', () {
      WordListSpec list4 = chapter1.wordLists[3];
      expect(model.title(3), list4.title);
    });
    test('word list selected', () {
      model.wordListSelected(4);
      expect(lastAction.selected, 4);
      expect(lastActionedState, initialState);
    });
  });
}