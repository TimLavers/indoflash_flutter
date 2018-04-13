import 'package:flutter_app2/vocab/word.dart';
import 'package:test/test.dart';

final Word word = new Word("satu", "one");

void main() {
  test('word', () {
    expect(word.word, "satu");
  });

  test('definition', () {
    expect(word.definition, "one");
  });
}
