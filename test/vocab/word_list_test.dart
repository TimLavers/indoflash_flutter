import 'package:flutter_app2/vocab/word.dart';
import 'package:flutter_app2/vocab/word_list.dart';
import 'package:test/test.dart';

final Word satu = new Word("satu", "one");
final Word dua = new Word("dua", "two");
final Word tiga = new Word("tiga", "three");
final WordList w123 = new WordList.fromList([satu, dua, tiga]);

void main() {

  test('words', () {
    expect(new WordList.fromList([]).words.isEmpty, true);
    expect(w123.words.length, 3);
    expect(w123.words[0], satu);
    expect(w123.words[1], dua);
    expect(w123.words[2], tiga);
  });

  test('add word', () {
    WordList w12 = new WordList.fromList([satu, dua]);
    w12.add(tiga);
    expect(w12==w123, true);
  });

  test('toString', () {
    expect(w123.toString(), 'WordList[Word{word: satu, definition: one}, Word{word: dua, definition: two}, Word{word: tiga, definition: three}]');
  });

  test('equals', () {
    WordList listA = new WordList.fromList([]);
    WordList listB = new WordList.fromList([]);
    expect(listA==listB, true);
    listA.add(satu);
    expect(listA==listB, false);
    listB.add(satu);
    expect(listA==listB, true);

    listA.add(dua);
    expect(listA==listB, false);
    listB.add(dua);
    expect(listA==listB, true);

    Word empat = new Word("empat", 'four');
    listA.add(empat);
    listA.add(tiga);
    listB.add(tiga);
    listB.add(empat);
    expect(listA==listB, false);
  });

  test('hashCode', (){
    WordList list = new WordList.fromList([satu, dua, tiga]);
    expect(list.hashCode==w123.hashCode, true);
  });
}