import 'package:flutter_app2/actions/actions.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/main_screen.dart';
import 'package:flutter_app2/spec/spec.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

void main() {
  group('MainScreenModel', () {
    final AppState initialState = new AppState.initial();
    final WordListSpec wordList0 =
        initialState.chapterState.applicationSpec.chapters[0].wordLists[0];
    var lastAction;

    AppState appReducer(AppState state, action) {
      lastAction = action;
      return state;
    }

    final store = Store<AppState>(
      appReducer,
      initialState: initialState,
    );
    MainScreenModel model = MainScreenModel(store);

    test('listName', () {
      expect(model.listName, wordList0.title);
    });

    test('index', () {
      expect(model.index, 0);
    });

    test('word state', () {
      expect(model.wordState, new WordState(0, false));
    });

    test('callback',() {
      model.callbackForNext();
      expect(lastAction, isInstanceOf<WordNext>());
    });

    //This test fails because the lesson file asset is not found during tests.
//    test('word', () async {
//      Word retrieved = await model.word;
//      expect(retrieved.word, 'satu');//The first entry.
//    });
  });
}
