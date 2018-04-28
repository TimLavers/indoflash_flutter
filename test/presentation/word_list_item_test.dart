import 'package:flutter/material.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/word_list_selector.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('WordListItem', (WidgetTester tester) async {
    var itemKey = wordListItemKey(3);
    var title = 'List 4';
    var index = 3;
    int selected;
    WordListSelected callback = (list) {
      selected = list;
    };

    await tester.pumpWidget(
      new StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return MaterialApp(
            home: Card(child: WordListItem(title, callback, index))
          );
        },
      ),
    );
    var byKey = find.byKey(itemKey);
    print(byKey);
    await tester.tap(byKey);

    expect(selected, index);
  });
}