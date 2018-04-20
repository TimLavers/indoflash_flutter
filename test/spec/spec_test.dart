import 'package:xml/xml.dart' as xml;
import 'package:flutter_app2/spec/spec.dart';
import 'package:test/test.dart';

void main() {
  test('toString', () {
    var title = "Chapter 1";
    Spec spec = new Spec.fromString(title);
    expect(spec.toString(), title);
  });

  test('construct from XML', () {
    String text = '''<WordList><Title>Lesson 1</Title><File>lesson1</File></WordList>''';
    xml.XmlParent parent = xml.parse(text);
    Spec spec = new Spec.fromXml(parent);
    expect(spec.title, 'Lesson 1');
  });

  test('construct from title', () {
    var title = "Chapter 1";
    Spec spec = new Spec.fromString(title);
    expect(spec.title, title);
  });
}
