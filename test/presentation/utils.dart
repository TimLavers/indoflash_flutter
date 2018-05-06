import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

String textForKey(Key key) {
  var root = find.byKey(key).evaluate();
  StatelessElement element = (root.first as StatelessElement);
  RichText richText = element.build() as RichText;
  return richText.text.text;
}

String iconForKey(Key key) {
  var byKey = find.byKey(key);
  StatelessElement element = (byKey.evaluate().first as StatelessElement);
  var build = element.build();
  var image = (build as RawMaterialButton).child as Image;
  return (image.image as AssetImage).assetName;
}
void checkIconForFlatButton(Key key, WidgetTester tester, IconData expected) {
  FlatButton button = tester.widget(find.byKey(key));
  IconData glyph = (button.child as Icon).icon;
  expect(glyph, expected);
}

void checkIconForFloatingActionButton(Key key, WidgetTester tester, IconData expected) {
  FloatingActionButton button = tester.widget(find.byKey(key));
  IconData glyph = (button.child as Icon).icon;
  expect(glyph, expected);
}