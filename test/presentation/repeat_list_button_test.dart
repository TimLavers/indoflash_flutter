import 'package:flutter/material.dart';
import 'package:flutter_app2/keys/keys.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/main_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  var clickCount = 0;
  createUI(WordState wordState) =>
      MaterialApp(home: RepeatListButton(() => clickCount++));

  testWidgets('RepeatListButton', (WidgetTester tester) async {
    //Check the text.
    var widget = createUI(WordState(9, true));
    await tester.pumpWidget(widget);
    expect(textForKey(repeateListButtonKey), 'Repeat List');
    expect(clickCount, 0);
    //Check that tapping the button activates the callback.
    await tester.tap(find.byKey(repeateListButtonKey));
    expect(clickCount, 1);
    //Check that tapping the button activates the callback.
    await tester.tap(find.byKey(repeateListButtonKey));
    expect(clickCount, 2);
  });
}