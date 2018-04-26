import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app2/presentation/buttons.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Buttons', (WidgetTester tester) async {
    var itemPressed;

    final widget = MaterialApp(
      title: "Testing",
      home: Scaffold(
        body: Container(),
        bottomNavigationBar: new BottomNavigationBar(
            onTap: (int index) {
              itemPressed = index;
            },
            items: <BottomNavigationBarItem>[
              createHomeNavigationButton(),
              createWordListNavigationButton(),
              createChapterListNavigationButton(),
            ]),
      ),
    );
    await tester.pumpWidget(widget);

    //Find and tap the home button.
    var byKey = find.byIcon(Icons.home);
    await tester.tap(byKey);
    expect(itemPressed, 0);

    //Find and tap the chapter lists button.
    byKey = find.byIcon(Icons.add_call);
    await tester.tap(byKey);
    expect(itemPressed, 1);

    //Find and tap the chapter lists button.
    byKey = find.byIcon(Icons.featured_video);
    await tester.tap(byKey);
    expect(itemPressed, 2);
  });
}