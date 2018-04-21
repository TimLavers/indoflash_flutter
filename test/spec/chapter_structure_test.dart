import 'package:flutter_app2/spec/spec.dart';
import 'package:test/test.dart';

const ch1Name = "Lessons 1 - 10";
const ch6Name = "Lessons 51 - 57";

void main() {

  test('singleton', () {
    ChapterStructure structure1 = new ChapterStructure();
    ChapterStructure structure2 = new ChapterStructure();
    expect(structure1 == structure2, true);
    expect(identical(structure1, structure2), true);
  });

  test('application spec', () {
    ApplicationSpec applicationSpec = new ChapterStructure().applicationSpec;
    expect(applicationSpec.chapters.length,6);
  });

  test('chapter1', () {
    ChapterSpec ch1 = new ChapterStructure().chapter1;
    expect(ch1.title,ch1Name);
  });

  test('all', () {
    ApplicationSpec applicationSpec = new ChapterStructure().applicationSpec;
    expect(applicationSpec.chapters.length, 6);
    ChapterSpec ch1 = applicationSpec.chapterForName(ch1Name);
    expect(ch1.title,ch1Name);
    for (int i=2; i<5;i++) {
      String chapterName = "Lessons ${i}1 - ${i+1}0";
      ChapterSpec chapterSpec = applicationSpec.chapterForName(chapterName);
      expect(chapterSpec.title, chapterName);
    }
    ChapterSpec ch6 = applicationSpec.chapterForName(ch6Name);
    expect(ch6.title,ch6Name);
  });
}