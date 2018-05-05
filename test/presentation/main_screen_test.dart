import 'package:flutter/material.dart';
import 'package:flutter_app2/actions/actions.dart';
import 'package:flutter_app2/keys/keys.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/main_screen.dart';
import 'package:flutter_app2/routes/routes.dart';
import 'package:flutter_app2/spec/spec.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

import 'utils.dart';

void main() {
  ChapterStructure chapterStructure = ChapterStructure();
  final ChapterSpec ch1 = chapterStructure.applicationSpec.chapters[0];
  final WordListSpec wl1 = ch1.wordLists[0];

  var wordListsPlaceholder = new Container();
  var chapterListsPlaceholder = new Container();
  var lastAction;

  final initialStateStore = Store<AppState>(
    (AppState state, action) {
      lastAction = action;
      return state;
    },
    initialState: AppState.initial(),
  );

  final int length1 = wl1.wordList.words.length;
  final AppState endOfLesson1State = AppState(ChapterState(ch1, wl1),
      WordState(length1 - 1, true), false);
  final endOfListStore = Store<AppState>(
    (AppState state, action) {
      lastAction = action;
      return state;
    },
    initialState: endOfLesson1State,
  );

  createMainScreen(Store<AppState> store) => StoreProvider<AppState>(
      store: store,
      child: StoreBuilder(
        builder: (BuildContext context, Store<AppState> store) => MaterialApp(
              title: "Testing",
              home: MainScreen(),
              routes: {
                listSelector: (context) => wordListsPlaceholder,
                chapterSelector: (context) => chapterListsPlaceholder
              },
            ),
      ));

  testWidgets('initial word', (WidgetTester tester) async {
    final widget = createMainScreen(initialStateStore);
    await tester.pumpWidget(widget);
    expect(textForKey(wordKey), 'anda'); //Lesson1 word 1
    expect(textForKey(definitionKey), '');
  });

  testWidgets('show next', (WidgetTester tester) async {
    final widget = createMainScreen(initialStateStore);
    await tester.pumpWidget(widget);
    checkIconForFloatingActionButton(navigateListButtonKey, tester, Icons.play_arrow);
    await tester.tap(find.byKey(navigateListButtonKey));
    expect(lastAction, isInstanceOf<WordNext>());
  });

  testWidgets('repeat list', (WidgetTester tester) async {
    expect(endOfListStore.state.atEndOfCurrentList(), true); //sanity
    final widget = createMainScreen(endOfListStore);
    await tester.pumpWidget(widget);
    checkIconForFloatingActionButton(navigateListButtonKey, tester, Icons.repeat);
    await tester.tap(find.byKey(navigateListButtonKey));
    expect(lastAction, isInstanceOf<RepeatList>());
  });

  testWidgets('shuffle', (WidgetTester tester) async {
    expect(endOfListStore.state.listState.shuffled, false); //sanity
    final widget = createMainScreen(endOfListStore);
    await tester.pumpWidget(widget);
    await tester.tap(find.byKey(shuffleToggleButtonKey));
    expect(lastAction, isInstanceOf<ToggleShuffle>());
  });

  testWidgets('Navigation Buttons', (WidgetTester tester) async {
    final widget = createMainScreen(initialStateStore);

    await tester.pumpWidget(widget);

    final NavigatorState navigator =
        tester.state<NavigatorState>(find.byType(Navigator));
    expect(navigator.canPop(), false);

    var byKey = find.byIcon(Icons.list);
    await tester.tap(byKey);

    expect(navigator.canPop(), true);
    expect(navigator.pop(wordListsPlaceholder), true);
  });
}
