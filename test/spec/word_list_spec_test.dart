import 'package:xml/xml.dart' as xml;
import 'package:flutter_app2/spec/spec.dart';
import 'package:test/test.dart';

void main() {
  test('construct from strings', () {
    var title = "Chapter 1";
    var fileName = "chapter1";
    WordListSpec spec = new WordListSpec.fromString(title, fileName);
    expect(spec.title, title);
    expect(spec.fileName, fileName);
  });

  test('construct from XML', () {
    String text = '''<WordList><Title>Lesson 1</Title><File>lesson1</File></WordList>''';
    xml.XmlParent parent = xml.parse(text);
    WordListSpec spec = new WordListSpec.fromXml(parent);
    expect(spec.title, 'Lesson 1');
    expect(spec.fileName, 'lesson1');
  });
}
