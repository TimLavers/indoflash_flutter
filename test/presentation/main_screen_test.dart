import 'package:flutter/material.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/main_screen.dart';
import 'package:flutter_app2/routes/routes.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

void main() {
  testWidgets('Navigation Buttons', (WidgetTester tester) async {
    var wordListsPlaceholder = new Container();
    var chapterListsPlaceholder = new Container();

    final theStore = Store<AppState>(
          (AppState state, action) => state,
      initialState: AppState(),
    );

    final widget = StoreProvider<AppState>(
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