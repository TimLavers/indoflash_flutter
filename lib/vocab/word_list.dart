import 'package:collection/collection.dart';
import 'dart:math';
import 'package:flutter_app2/vocab/word.dart';

class WordList {
  List<Word> _words = [];

  WordList.fromString(String data) {
    List<String> lines = data.split('\n');
    lines.forEach((line) {
      String trimmed = line.trim();
      if (trimmed.isNotEmpty) {
        List<String> pair = line.split('=');
        _words.add(new Word(pair[0].trim(), pair[1].trim()));
      }
    });
  }

  WordList.fromList(List<Word> words) {
    this._words = words;
  }

  void add(Word word) {
    if (!_words.contains(word)) {
      _words.add(word);
    }
  }

  List<Word> get words => _copyList(false);

  WordList shuffled() => WordList.fromList(_copyList(true));

  List<Word> _copyList(bool shuffle) {
    List<Word> newList = List<Word>();
    newList.addAll(_words);
    if (shuffle) {newList.shuffle(Random());}
    return newList;
  }

  void remove(Word word) => _words.remove(word);

  String toString() => "WordList$_words";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is WordList &&
              runtimeType == other.runtimeType &&
              ListEquality().equals(_words, other._words);

  @override
  int get hashCode => _words.length;

  String asPersistentData() {
    String wordString(Word word) => "${word.word}=${word.definition}\n";
    var buffer = new StringBuffer();
    _words.forEach((word) => buffer.write(wordString(word)));
    return buffer.toString();
  }
}