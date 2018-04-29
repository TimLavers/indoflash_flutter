import 'package:flutter/material.dart';
import 'package:flutter_app2/keys/keys.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/main_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  var clickCount = 0;
  createUI(WordState wordState) =>
      MaterialApp(home: ShowOrNextButton(wordState, () => clickCount++));

  testWidgets('ShowOrNextButton', (WidgetTester tester) async {
    //Check that the text is 'Next' if constructed
    //with true for showDefinition
    var widget = createUI(WordState(9, true));
    await tester.pumpWidget(widget);
    expect(textForKey(showOrNextButtonKey), 'Next');
    expect(clickCount, 0);
    //Check that tapping the button activates the callback.
    await tester.tap(find.byKey(showOrNextButtonKey));
    expect(clickCount, 1);
    //Check that tapping the button activates the callback.
    await tester.tap(find.byKey(showOrNextButtonKey));
    expect(clickCount, 2);
  });

  testWidgets('Display true', (WidgetTester tester) async {
    clickCount = 0;
    //Check that the text is 'Next' if constructed
    //with true for showDefinition
    var widget = createUI(WordState(9, false));
    await tester.pumpWidget(widget);
    expect(textForKey(showOrNextButtonKey), 'Show');
    expect(clickCount, 0);
    //Check that tapping the button activates the callback.
    await tester.tap(find.byKey(showOrNextButtonKey));
    expect(clickCount, 1);
  });
}