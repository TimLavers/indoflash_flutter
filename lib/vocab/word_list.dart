import 'package:flutter_app2/vocab/word.dart';

class WordList {
  final List<Word> words = [];


  WordList.fromList(List<Word> words);

// fun words(): List<Word> = words.toList()

  void add(Word word) {
    if (words.contains(word)) return
      words.add(word);
  }

  void remove(Word word) => words.remove(word);

  String toString() => "WordList$words";

//fun store(writer: Writer) {
//val bw = BufferedWriter(writer)
//words.forEach { bw.append("${it.word}=${it.definition}\n") }
//bw.close()
//}
}