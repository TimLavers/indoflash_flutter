import 'package:flutter/material.dart';
import 'package:flutter_app2/keys/keys.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/main_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  var clickCount = 0;
  createUI(ListState listState) =>
      MaterialApp(home: shuffleToggleButton(listState, () => clickCount++));

  testWidgets('shuffled', (WidgetTester tester) async {
    var widget = createUI(ListState(true, true));
    await tester.pumpWidget(widget);
    checkIconForFlatButton(shuffleToggleButtonKey, tester, Icons.straighten);
    expect(clickCount, 0);
    //Check that tapping the button activates the callback.
    await tester.tap(find.byKey(shuffleToggleButtonKey));
    expect(clickCount, 1);
    //Check that tapping the button activates the callback.
    await tester.tap(find.byKey(shuffleToggleButtonKey));
    expect(clickCount, 2);
  });

  testWidgets('straight', (WidgetTester tester) async {
    clickCount = 0;
    //Check that the text is 'Next' if constructed
    //with true for showDefinition
    var widget = createUI(ListState(false, false));
    await tester.pumpWidget(widget);
    checkIconForFlatButton(shuffleToggleButtonKey, tester, Icons.shuffle);
    expect(clickCount, 0);
    //Check that tapping the button activates the callback.
    await tester.tap(find.byKey(shuffleToggleButtonKey));
    expect(clickCount, 1);
  });
}