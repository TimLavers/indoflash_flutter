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

  test('to string', () {
    expect(word.toString(), "Word{word: satu, definition: one}");
  });

  test('equals', () {
    expect(word == new Word("satu", "1"), false);
    expect(word == new Word("1", "one"), false);
    expect(word == new Word("Satu", "one"), false);
    expect(word == new Word("satu", "One"), false);
    expect(word == new Word("satu", "one"), true);
  });

  test('hash code', () {
    expect(word.hashCode == new Word("satu", "one").hashCode, true);
  });
}
