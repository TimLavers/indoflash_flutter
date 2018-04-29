import 'dart:io';

import 'package:flutter_app2/spec/setup.dart';
import 'package:flutter_app2/vocab/word_list.dart';
import 'package:flutter_app2/vocab/lessons/lessons.dart';
import 'package:xml/xml.dart' as xml;

const TITLE = "Title";
const FILE_TAG = "File";
const CHAPTER = "Chapter";
const FAVOURITES = "Favourites";
const WORD_LIST = "WordList";
const FAVOURITES_FILE_NAME = "favourites";

class ChapterStructure {
  static final ChapterStructure _singleton = new ChapterStructure._internal();
  ApplicationSpec _applicationSpec;
  ChapterSpec _chapter1;

  factory ChapterStructure() {
    return _singleton;
  }

  ApplicationSpec get applicationSpec => _applicationSpec;

  ChapterSpec get chapter1 => _chapter1;

  ChapterStructure._internal() {
    xml.XmlParent document = xml.parse(STRUCTURE);
    _applicationSpec = new ApplicationSpec.fromXml(document);
    _chapter1 = applicationSpec.chapterForName("Lessons 1 - 10");
  }
}

class Spec {
  String title;

  Spec.fromString(String title) {
    this.title = title;
  }

  Spec.fromXml(xml.XmlParent parent) {
    title = parent.findAllElements(TITLE).first.text;
  }

  @override
  String toString() => title;
}

class WordListSpec extends Spec {
  String fileName;

  WordListSpec.fromString(String title, String fileName)
      : super.fromString(title) {
    this.fileName = fileName;
  }

  WordListSpec.fromXml(xml.XmlParent parent) : super.fromXml(parent) {
    fileName = parent.findAllElements(FILE_TAG).first.text;
  }

  WordList get wordList => Lessons().lesson(fileName);//todo test
}

class ChapterSpec extends Spec {
  List<WordListSpec> wordLists = [];

  ChapterSpec.fromXml(xml.XmlParent parent) : super.fromXml(parent) {
    parent
        .findAllElements(WORD_LIST)
        .forEach((child) => wordLists.add(new WordListSpec.fromXml(child)));
    wordLists
        .add(new WordListSpec.fromString(FAVOURITES, FAVOURITES_FILE_NAME));
  }
}

class ApplicationSpec extends Spec {
  List<ChapterSpec> chapters = [];

  ApplicationSpec.fromXml(xml.XmlParent parent) : super.fromXml(parent) {
    parent.findAllElements(CHAPTER).forEach(
        (chapterNode) => chapters.add(new ChapterSpec.fromXml(chapterNode)));
  }

  ChapterSpec chapterForName(String name) =>
      chapters.firstWhere((chapterSpec) => chapterSpec.title == name);
}
