import 'package:flutter_app2/vocab/word.dart';
import 'package:collection/collection.dart';

class WordList {
  List<Word> words = [];


  WordList.fromList(List<Word> words) {
    this.words = words;
  }

// fun words(): List<Word> = words.toList()

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
              new  ListEquality().equals(words, other.words);

  @override
  int get hashCode => words.length;




//fun store(writer: Writer) {
//val bw = BufferedWriter(writer)
//words.forEach { bw.append("${it.word}=${it.definition}\n") }
//bw.close()
//}
}