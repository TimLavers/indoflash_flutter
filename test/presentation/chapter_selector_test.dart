import 'package:flutter_app2/actions/actions.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/chapter_selector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/chapter_selector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

import 'package:flutter_redux/flutter_redux.dart';

void main() {
  testWidgets('ChapterSelector', (WidgetTester tester) async {
    var item3Key = chapterItemKey(3);
    var index = 3;
    int selected;
    var lastAction;
    var lastState;
    ChapterSelected callback = (chapter) {
      selected = chapter;
    };

    final store = new Store<AppState>(
      (AppState state, action) {
        lastState = state;
        lastAction = action;
        return state;
      }
    );
    final widget = new StoreProvider<AppState>(
      store: store,
      child: new StoreBuilder(
        builder: (context, store) =>new ChapterSelector()
    ));
    await tester.pumpWidget(widget);

    var byKey = find.byKey(item3Key);
    print(byKey);
    await tester.tap(byKey);

    expect((lastAction as ChapterSelectedAction).selected, index);
  });
}