import 'package:xml/xml.dart' as xml;
import 'package:flutter_app2/spec/spec.dart';
import 'package:test/test.dart';

const XML = '''<Chapter> 
<Title>Lessons 1 - 10</Title> 
<WordList><Title>Lesson 2</Title><File>lesson2</File></WordList>
<WordList><Title>Lesson 3</Title><File>lesson3</File></WordList>
</Chapter>''';

void main() {


  test('construct from XML', () {
    xml.XmlParent parent = xml.parse(XML);
    ChapterSpec spec = new ChapterSpec.fromXml(parent);
    expect(spec.title, 'Lessons 1 - 10');
    expect(spec.wordLists.length, 3);
    expect(spec.wordLists[0].title, 'Lesson 2');
    expect(spec.wordLists[0].fileName, 'lesson2');
//    expect(spec.wordLists[1].title, 'Lesson 3');
//    expect(spec.wordLists[1].fileName, 'lesson3');
//    expect(spec.wordLists[2].title, FAVOURITES);
//    expect(spec.wordLists[2].fileName, FAVOURITES_FILE_NAME);
  });
}
