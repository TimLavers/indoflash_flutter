import 'package:flutter/material.dart';
import 'package:flutter_app2/actions/actions.dart';
import 'package:flutter_app2/keys/keys.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/main_screen.dart';
import 'package:flutter_app2/routes/routes.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

import 'utils.dart';

void main() {
  var wordListsPlaceholder = new Container();
  var chapterListsPlaceholder = new Container();
  var lastAction;

  final theStore = Store<AppState>(
        (AppState state, action) {
          lastAction = action;
          return state;
        },
    initialState: AppState.initial(),
  );

  createMainScreen() => StoreProvider<AppState>(
      store: theStore,
      child: StoreBuilder(
        builder: (BuildContext context, Store<AppState> store) =>
            MaterialApp(
              title: "Testing",
              home: MainScreen(),
              routes: {
                listSelector: (context) => wordListsPlaceholder,
                chapterSelector: (context) => chapterListsPlaceholder
              },
            ),
      ));

  testWidgets('initial word', (WidgetTester tester) async{
    final widget = createMainScreen();
    await tester.pumpWidget(widget);
    expect(textForKey(wordKey), 'anda');//Lesson1 word 1
    expect(textForKey(definitionKey), '');
  });

  testWidgets('show next', (WidgetTester tester) async{
    final widget = createMainScreen();
    await tester.pumpWidget(widget);
    await tester.tap(find.byKey(showOrNextButtonKey));
    expect(lastAction, isInstanceOf<WordNext>());
  });

  testWidgets('Navigation Buttons', (WidgetTester tester) async {
    final widget = createMainScreen();

    await tester.pumpWidget(widget);

    final NavigatorState navigator = tester.state<NavigatorState>(
        find.byType(Navigator));
    expect(navigator.canPop(), false);

    var byKey = find.byIcon(Icons.add_call);
    await tester.tap(byKey);

    expect(navigator.canPop(), true);
    expect(navigator.pop(wordListsPlaceholder), true);
  });
}