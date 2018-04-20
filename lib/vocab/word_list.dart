import 'package:collection/collection.dart';
import 'package:flutter_app2/vocab/word.dart';

class WordList {
  List<Word> words = [];

  WordList.fromString(String data) {
    List<String> lines = data.split('\n');
    lines.forEach((line) {
      String trimmed = line.trim();
      if (trimmed.isNotEmpty) {
        List<String> pair = line.split('=');
        words.add(new Word(pair[0].trim(), pair[1].trim()));
      }
    });
  }

  WordList.fromList(List<Word> words) {
    this.words = words;
  }

  void add(Word word) {
    if (!words.contains(word)) {
      words.add(word);
    }
  }

  void remove(Word word) => words.remove(word);

  String toString() => "WordList$words";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is WordList &&
              runtimeType == other.runtimeType &&
              new ListEquality().equals(words, other.words);

  @override
  int get hashCode => words.length;

  String asPersistentData() {
    String wordString(Word word) => "${word.word}=${word.definition}\n";
    var buffer = new StringBuffer();
    words.forEach((word) => buffer.write(wordString(word)));
    return buffer.toString();
  }
}