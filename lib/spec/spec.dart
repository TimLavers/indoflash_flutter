import 'package:xml/xml.dart' as xml;

const TITLE = "Title";
const FILE_TAG = "Title";
const CHAPTER = "Chapter";
const FAVOURITES = "Favourites";
const WORD_LIST = "WordList";
const FAVOURITES_FILE_NAME = "favourites";

class Spec {
  String title;

  Spec.fromString(String title) {
    this.title = title;
  }

  Spec.fromXml(xml.XmlParent parent) {
    title = parent
        .findAllElements(TITLE)
        .first
        .text;
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
    fileName = parent
        .findAllElements(FILE_TAG)
        .first
        .text;
  }
}

class ChapterSpec extends Spec {
  List<WordListSpec> wordLists = [];

  ChapterSpec.fromXml(xml.XmlParent parent) : super.fromXml(parent) {
    parent.findAllElements(WORD_LIST).forEach((child) => wordLists.add(new WordListSpec.fromXml(child)));
    wordLists.add(new WordListSpec.fromString(FAVOURITES, FAVOURITES_FILE_NAME));
  }
}