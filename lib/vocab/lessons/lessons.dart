import 'package:flutter_app2/vocab/lessons/lesson1.dart';
import 'package:flutter_app2/vocab/word_list.dart';

///
// This class is a horrible hack to work around my inability
// to load the contents of the lessons files synchronously
// and from non-widget classes.
//
class Lessons {//todo test
  static final Lessons _singleton = new Lessons._internal();
  Map<String, String> _rawStrings = Map<String, String>();
  Map<String, WordList> _cache = Map<String, WordList>();

  factory Lessons() {
    return _singleton;
  }

  WordList lesson(String fileName) {
    _cache.putIfAbsent(
        fileName, () => WordList.fromString(_rawStrings[fileName]));
    return _cache[fileName];
  }

  Lessons._internal() {
    _rawStrings.putIfAbsent("lesson1", () => lesson1);
  }
}
