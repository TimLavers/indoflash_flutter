import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

String textForKey(Key key) {
  var byKey = find.byKey(key);
  StatelessElement element = (byKey.evaluate().first as StatelessElement);
  var build = element.build();
  RichText richText = build as RichText;
  return richText.text.text;
}