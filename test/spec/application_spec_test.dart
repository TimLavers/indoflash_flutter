import 'package:xml/xml.dart' as xml;
import 'package:flutter_app2/spec/spec.dart';
import 'package:test/test.dart';

const XML = '''<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<FlashCardsApp><AppName>IndoFlash</AppName>    
    <Chapters>
        <Chapter>
            <Title>Lessons 1 - 10</Title>
            <WordList>
                <Title>Lesson 1</Title>
                <File>lesson1</File>
            </WordList>
            <WordList>
                <Title>Lesson 2</Title>
                <File>lesson2</File>
            </WordList>
        </Chapter>
        <Chapter>
            <Title>Lessons 11 - 20</Title>
            <WordList>
                <Title>Lesson 11</Title>
                <File>lesson11</File>
            </WordList>
            <WordList>
                <Title>Lesson 12</Title>
                <File>lesson12</File>
            </WordList>
        </Chapter>
    </Chapters>
</FlashCardsApp>''';

void main() {
  test('construct from XML', () {
    xml.XmlParent parent = xml.parse(XML);
    ApplicationSpec spec = new ApplicationSpec.fromXml(parent);
    expect(spec.chapters.length, 2);
    ChapterSpec ch0 = spec.chapters[0];
    expect("Lessons 1 - 10", ch0.title);
    expect(ch0.wordLists.length, 3);
    expect(ch0.wordLists[0].title, 'Lesson 1');
    expect(ch0.wordLists[0].fileName, 'lesson1');
    expect(ch0.wordLists[1].title, 'Lesson 2');
    expect(ch0.wordLists[1].fileName, 'lesson2');
    expect(ch0.wordLists[2].title, FAVOURITES);
    expect(ch0.wordLists[2].fileName, FAVOURITES_FILE_NAME);

    ChapterSpec ch1 = spec.chapters[1];
    expect("Lessons 11 - 20", ch1.title);
    expect(ch1.wordLists.length, 3);
    expect(ch1.wordLists[0].title, 'Lesson 11');
    expect(ch1.wordLists[0].fileName, 'lesson11');
    expect(ch1.wordLists[1].title, 'Lesson 12');
    expect(ch1.wordLists[1].fileName, 'lesson12');
    expect(ch1.wordLists[2].title, FAVOURITES);
    expect(ch1.wordLists[2].fileName, FAVOURITES_FILE_NAME);
  });

  test('chapter for name', () {
    xml.XmlParent parent = xml.parse(XML);
    ApplicationSpec spec = new ApplicationSpec.fromXml(parent);
    var chapterName = "Lessons 11 - 20";
    var chapter = spec.chapterForName(chapterName);
    expect(chapter.title, chapterName);
    expect(chapter.wordLists.length, 3);
  });
}