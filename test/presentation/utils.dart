import 'package:flutter/material.dart';
import 'package:flutter_app2/keys/keys.dart';
import 'package:flutter_app2/presentation/main_screen.dart';
import 'package:flutter_app2/vocab/word.dart';
import 'package:flutter_test/flutter_test.dart';

String textForKey(Key key) {
  var byKey = find.byKey(key);
  StatelessElement element = (byKey.evaluate().first as StatelessElement);
  var build = element.build();
  RichText richText = build as RichText;
  return richText.text.text;
}