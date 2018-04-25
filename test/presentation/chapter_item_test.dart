import 'package:flutter/material.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/chapter_selector.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ChapterItem', (WidgetTester tester) async {
    var itemKey = chapterItemKey(3);
    var title = 'The Beginning';
    var index = 3;
    int selected;
    ChapterSelected callback = (chapter) {
      selected = chapter;
    };

    await tester.pumpWidget(
      new StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return MaterialApp(
            home: Card(child: ChapterItem(title, callback, index))
          );
        },
      ),
    );
    var byKey = find.byKey(itemKey);
    print(byKey);
    await tester.tap(byKey);

    expect(selected, index);

    print("finder: $byKey");

//    byKey.first.

    //todo test text, etc
  });
}