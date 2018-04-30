import 'package:flutter_app2/vocab/lessons/lessons.dart';
import 'package:flutter_app2/vocab/word.dart';
import 'package:flutter_app2/vocab/word_list.dart';
import 'package:test/test.dart';

void main() {
  test('singleton', () {
    Lessons lessons0 = Lessons();
    Lessons lessons1 = Lessons();
    expect(identical(lessons0, lessons1),true);
  });

  test('lesson 1', () {
    WordList lesson1 = Lessons().lesson("lesson1");
    expect(lesson1.words.first, Word('anda', 'you'));
    expect(lesson1.words.length, 24);
  });

  test('all lessons', () {
    Lessons lessons = Lessons();
    for (int i=1; i<=57; i++){
      WordList list = lessons.lesson('lesson$i');
      expect(list.words.length, greaterThan(3));
    }
  });
}
