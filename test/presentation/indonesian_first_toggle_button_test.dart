import 'package:flutter/material.dart';
import 'package:flutter_app2/keys/keys.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/main_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  var clickCount = 0;
  createUI(WordState state) =>
      MaterialApp(home: indonesianFirstToggleButton(state, () => clickCount++));

  testWidgets('indonesian first', (WidgetTester tester) async {
    var widget = createUI(WordState(4, true));
    await tester.pumpWidget(widget);
    checkIconForFlatButton(indonesianFirstToggleButtonKey, tester, Icons.arrow_upward);
    expect(clickCount, 0);
    //Check that tapping the button activates the callback.
    await tester.tap(find.byKey(indonesianFirstToggleButtonKey));
    expect(clickCount, 1);
    //Check that tapping the button activates the callback.
    await tester.tap(find.byKey(indonesianFirstToggleButtonKey));
    expect(clickCount, 2);
  });

  testWidgets('straight', (WidgetTester tester) async {
    clickCount = 0;
    //Check that the text is 'Next' if constructed
    //with true for showDefinition
    var widget = createUI(WordState(2, true).toggleIndonesianFirst());
    await tester.pumpWidget(widget);
    checkIconForFlatButton(indonesianFirstToggleButtonKey, tester, Icons.arrow_downward);
    expect(clickCount, 0);
    //Check that tapping the button activates the callback.
    await tester.tap(find.byKey(indonesianFirstToggleButtonKey));
    expect(clickCount, 1);
  });
}