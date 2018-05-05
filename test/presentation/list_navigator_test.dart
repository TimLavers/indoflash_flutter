import 'package:flutter/material.dart';
import 'package:flutter_app2/keys/keys.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/main_screen.dart';
import 'package:flutter_app2/spec/spec.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

class DummyNavigation implements Navigation {
  final bool atEnd;

  DummyNavigation(this.atEnd);

  @override
  bool atEndOfCurrentList() => atEnd;
}

void main() {
  var nextCount = 0;
  var repeatCount = 0;
  createUI(bool atEnd) => MaterialApp(
      home: ListNavigator(
              DummyNavigation(atEnd),
              () => nextCount++,
              () => repeatCount++)
          .button());

  setUp(() {
    nextCount = 0;
    repeatCount = 0;
  });

  testWidgets('in body', (WidgetTester tester) async {
    //Check the icon.
    var widget = createUI(false);
    await tester.pumpWidget(widget);
    checkIconForFloatingActionButton(navigateListButtonKey, tester, Icons.play_arrow);
    //Check that tapping the button activates the next callback.
    expect(nextCount, 0);
    expect(repeatCount, 0);
    await tester.tap(find.byKey(navigateListButtonKey));
    expect(nextCount, 1);
    expect(repeatCount, 0);
  });

  testWidgets('at end', (WidgetTester tester) async {
    //Check the icon.
    var widget = createUI(true);
    await tester.pumpWidget(widget);
    checkIconForFloatingActionButton(navigateListButtonKey, tester, Icons.repeat);
    //Check that tapping the button activates the repeat callback.
    expect(nextCount, 0);
    expect(repeatCount, 0);
    await tester.tap(find.byKey(navigateListButtonKey));
    expect(nextCount, 0);
    expect(repeatCount, 1);
  });
}
