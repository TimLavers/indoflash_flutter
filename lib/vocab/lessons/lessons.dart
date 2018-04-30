import 'package:flutter_app2/vocab/lessons/lesson1.dart';
import 'package:flutter_app2/vocab/lessons/lesson10.dart';
import 'package:flutter_app2/vocab/lessons/lesson11.dart';
import 'package:flutter_app2/vocab/lessons/lesson12.dart';
import 'package:flutter_app2/vocab/lessons/lesson13.dart';
import 'package:flutter_app2/vocab/lessons/lesson14.dart';
import 'package:flutter_app2/vocab/lessons/lesson15.dart';
import 'package:flutter_app2/vocab/lessons/lesson16.dart';
import 'package:flutter_app2/vocab/lessons/lesson17.dart';
import 'package:flutter_app2/vocab/lessons/lesson18.dart';
import 'package:flutter_app2/vocab/lessons/lesson19.dart';
import 'package:flutter_app2/vocab/lessons/lesson2.dart';
import 'package:flutter_app2/vocab/lessons/lesson20.dart';
import 'package:flutter_app2/vocab/lessons/lesson21.dart';
import 'package:flutter_app2/vocab/lessons/lesson22.dart';
import 'package:flutter_app2/vocab/lessons/lesson23.dart';
import 'package:flutter_app2/vocab/lessons/lesson24.dart';
import 'package:flutter_app2/vocab/lessons/lesson25.dart';
import 'package:flutter_app2/vocab/lessons/lesson26.dart';
import 'package:flutter_app2/vocab/lessons/lesson27.dart';
import 'package:flutter_app2/vocab/lessons/lesson28.dart';
import 'package:flutter_app2/vocab/lessons/lesson29.dart';
import 'package:flutter_app2/vocab/lessons/lesson3.dart';
import 'package:flutter_app2/vocab/lessons/lesson30.dart';
import 'package:flutter_app2/vocab/lessons/lesson31.dart';
import 'package:flutter_app2/vocab/lessons/lesson32.dart';
import 'package:flutter_app2/vocab/lessons/lesson33.dart';
import 'package:flutter_app2/vocab/lessons/lesson34.dart';
import 'package:flutter_app2/vocab/lessons/lesson35.dart';
import 'package:flutter_app2/vocab/lessons/lesson36.dart';
import 'package:flutter_app2/vocab/lessons/lesson37.dart';
import 'package:flutter_app2/vocab/lessons/lesson38.dart';
import 'package:flutter_app2/vocab/lessons/lesson39.dart';
import 'package:flutter_app2/vocab/lessons/lesson4.dart';
import 'package:flutter_app2/vocab/lessons/lesson40.dart';
import 'package:flutter_app2/vocab/lessons/lesson41.dart';
import 'package:flutter_app2/vocab/lessons/lesson42.dart';
import 'package:flutter_app2/vocab/lessons/lesson43.dart';
import 'package:flutter_app2/vocab/lessons/lesson44.dart';
import 'package:flutter_app2/vocab/lessons/lesson45.dart';
import 'package:flutter_app2/vocab/lessons/lesson46.dart';
import 'package:flutter_app2/vocab/lessons/lesson47.dart';
import 'package:flutter_app2/vocab/lessons/lesson48.dart';
import 'package:flutter_app2/vocab/lessons/lesson49.dart';
import 'package:flutter_app2/vocab/lessons/lesson5.dart';
import 'package:flutter_app2/vocab/lessons/lesson50.dart';
import 'package:flutter_app2/vocab/lessons/lesson51.dart';
import 'package:flutter_app2/vocab/lessons/lesson52.dart';
import 'package:flutter_app2/vocab/lessons/lesson53.dart';
import 'package:flutter_app2/vocab/lessons/lesson54.dart';
import 'package:flutter_app2/vocab/lessons/lesson55.dart';
import 'package:flutter_app2/vocab/lessons/lesson56.dart';
import 'package:flutter_app2/vocab/lessons/lesson57.dart';
import 'package:flutter_app2/vocab/lessons/lesson6.dart';
import 'package:flutter_app2/vocab/lessons/lesson7.dart';
import 'package:flutter_app2/vocab/lessons/lesson8.dart';
import 'package:flutter_app2/vocab/lessons/lesson9.dart';
import 'package:flutter_app2/vocab/word_list.dart';

///
// This class is a horrible hack to work around my inability
// to load the contents of the lessons files synchronously
// and from non-widget classes. Note that we can't use
// reflection (as it breaks tree-shaking) so we have to
// enter all of the references manually.
//
class Lessons {
  static final Lessons _singleton = new Lessons._internal();
  Map<String, String> _rawStrings = Map<String, String>();
  Map<String, WordList> _cache = Map<String, WordList>();

  factory Lessons() {
    return _singleton;
  }

  WordList lesson(String fileName) {
    _cache.putIfAbsent(fileName, () => WordList.fromString(_rawStrings[fileName]));
    return _cache[fileName];
  }

  Lessons._internal() {
    _rawStrings.putIfAbsent("lesson1", () => lesson1);
    _rawStrings.putIfAbsent("lesson2", () => lesson2);
    _rawStrings.putIfAbsent("lesson3", () => lesson3);
    _rawStrings.putIfAbsent("lesson4", () => lesson4);
    _rawStrings.putIfAbsent("lesson5", () => lesson5);
    _rawStrings.putIfAbsent("lesson6", () => lesson6);
    _rawStrings.putIfAbsent("lesson7", () => lesson7);
    _rawStrings.putIfAbsent("lesson8", () => lesson8);
    _rawStrings.putIfAbsent("lesson9", () => lesson9);

    _rawStrings.putIfAbsent("lesson10", () => lesson10);
    _rawStrings.putIfAbsent("lesson11", () => lesson11);
    _rawStrings.putIfAbsent("lesson12", () => lesson12);
    _rawStrings.putIfAbsent("lesson13", () => lesson13);
    _rawStrings.putIfAbsent("lesson14", () => lesson14);
    _rawStrings.putIfAbsent("lesson15", () => lesson15);
    _rawStrings.putIfAbsent("lesson16", () => lesson16);
    _rawStrings.putIfAbsent("lesson17", () => lesson17);
    _rawStrings.putIfAbsent("lesson18", () => lesson18);
    _rawStrings.putIfAbsent("lesson19", () => lesson19);

    _rawStrings.putIfAbsent("lesson20", () => lesson20);
    _rawStrings.putIfAbsent("lesson21", () => lesson21);
    _rawStrings.putIfAbsent("lesson22", () => lesson22);
    _rawStrings.putIfAbsent("lesson23", () => lesson23);
    _rawStrings.putIfAbsent("lesson24", () => lesson24);
    _rawStrings.putIfAbsent("lesson25", () => lesson25);
    _rawStrings.putIfAbsent("lesson26", () => lesson26);
    _rawStrings.putIfAbsent("lesson27", () => lesson27);
    _rawStrings.putIfAbsent("lesson28", () => lesson28);
    _rawStrings.putIfAbsent("lesson29", () => lesson29);

    _rawStrings.putIfAbsent("lesson30", () => lesson30);
    _rawStrings.putIfAbsent("lesson31", () => lesson31);
    _rawStrings.putIfAbsent("lesson32", () => lesson32);
    _rawStrings.putIfAbsent("lesson33", () => lesson33);
    _rawStrings.putIfAbsent("lesson34", () => lesson34);
    _rawStrings.putIfAbsent("lesson35", () => lesson35);
    _rawStrings.putIfAbsent("lesson36", () => lesson36);
    _rawStrings.putIfAbsent("lesson37", () => lesson37);
    _rawStrings.putIfAbsent("lesson38", () => lesson38);
    _rawStrings.putIfAbsent("lesson39", () => lesson39);

    _rawStrings.putIfAbsent("lesson40", () => lesson40);
    _rawStrings.putIfAbsent("lesson41", () => lesson41);
    _rawStrings.putIfAbsent("lesson42", () => lesson42);
    _rawStrings.putIfAbsent("lesson43", () => lesson43);
    _rawStrings.putIfAbsent("lesson44", () => lesson44);
    _rawStrings.putIfAbsent("lesson45", () => lesson45);
    _rawStrings.putIfAbsent("lesson46", () => lesson46);
    _rawStrings.putIfAbsent("lesson47", () => lesson47);
    _rawStrings.putIfAbsent("lesson48", () => lesson48);
    _rawStrings.putIfAbsent("lesson49", () => lesson49);

    _rawStrings.putIfAbsent("lesson50", () => lesson50);
    _rawStrings.putIfAbsent("lesson51", () => lesson51);
    _rawStrings.putIfAbsent("lesson52", () => lesson52);
    _rawStrings.putIfAbsent("lesson53", () => lesson53);
    _rawStrings.putIfAbsent("lesson54", () => lesson54);
    _rawStrings.putIfAbsent("lesson55", () => lesson55);
    _rawStrings.putIfAbsent("lesson56", () => lesson56);
    _rawStrings.putIfAbsent("lesson57", () => lesson57);
  }
}