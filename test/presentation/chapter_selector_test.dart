import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app2/actions/actions.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/chapter_selector.dart';
import 'package:flutter_app2/routes/routes.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

void main() {
  testWidgets('ChapterSelector', (WidgetTester tester) async {
    var item3Key = chapterItemKey(3);
    var index = 3;
    var lastAction;
    bool listsRoutePushed = false;

    final theStore = Store<AppState>(
          (AppState state, action) {
        lastAction = action;
        return state;
      },
      initialState: AppState(),
    );
    final widget = StoreProvider<AppState>(
        store: theStore,
        child: StoreBuilder(
          builder: (BuildContext context, Store<AppState> store) =>
              MaterialApp(
                title: "Testing",
                home: ChapterSelector(),
                routes: {
                  listSelector: (context) {
                    listsRoutePushed = true;
                    return Container();
                  },
                },
              ),
        ));
    await tester.pumpWidget(widget);

    var byKey = find.byKey(item3Key);
    await tester.tap(byKey);
    await tester.pump();

    //A ChapterSelectedAction should have been thrown.
    expect((lastAction as ChapterSelectedAction).selected, index);
    //The listSelector route should have been requested.
    expect(listsRoutePushed, true);
  });
}