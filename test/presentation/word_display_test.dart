import 'package:flutter/material.dart';
import 'package:flutter_app2/keys/keys.dart';
import 'package:flutter_app2/presentation/main_screen.dart';
import 'package:flutter_app2/vocab/word.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
testWidgets('WordDisplay', (WidgetTester tester) async {
  final Word word = Word('guru','teacher');

  //Check that the definition is blank if constructed
  //with false for the display option.
  var widget = MaterialApp(home: WordDisplay(word, false, true));
  await tester.pumpWidget(widget);
  expect(textForKey(wordKey), word.word);
  expect(textForKey(definitionKey), '');

  //Check that the definition is blank if constructed
  //with true for the display option.
  widget = MaterialApp(home: WordDisplay(word, true, true));
  await tester.pumpWidget(widget);
  expect(textForKey(wordKey), word.word);
  expect(textForKey(definitionKey), word.definition);
});

  testWidgets('indonesian second', (WidgetTester tester) async {
    final Word word = Word('guru','teacher');

    //Check that the definition is blank if constructed
    //with false for the display option.
    var widget = MaterialApp(home: WordDisplay(word, false, false));
    await tester.pumpWidget(widget);
    expect(textForKey(wordKey), word.definition);
    expect(textForKey(definitionKey), '');

    //Check that the definition is blank if constructed
    //with true for the display option.
    widget = MaterialApp(home: WordDisplay(word, true, false));
    await tester.pumpWidget(widget);
    expect(textForKey(wordKey), word.definition);
    expect(textForKey(definitionKey), word.word);
  });
}