import 'package:flutter_app2/vocab/word.dart';
import 'package:flutter_app2/vocab/word_list.dart';
import 'package:test/test.dart';

final Word satu = new Word("satu", "one");
final Word dua = new Word("dua", "two");
final Word tiga = new Word("tiga", "three");
final WordList w123 = new WordList.fromList([satu, dua, tiga]);
final Word empat = new Word("empat", 'four');

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

  test('add word to empty', () {
    WordList wl = new WordList.fromList([]);
    wl.add(satu);
    wl.add(dua);
    wl.add(tiga);
    expect(wl==w123, true);
  });

  test('remove word', () {
    WordList wl = new WordList.fromList([satu, dua, tiga, empat]);
    wl.remove(empat);
    expect(wl==w123, true);

    wl.remove(dua);
    expect(wl, new WordList.fromList([satu, tiga]));

    wl.remove(satu);
    expect(wl, new WordList.fromList([tiga]));
  });

  test('remove absent word', () {
    WordList wl = new WordList.fromList([satu, dua, tiga]);
    wl.remove(empat);
    expect(wl==w123, true);
  });

  test('remove from empty', () {
    WordList wl = new WordList.fromList([]);
    wl.remove(empat);
    expect(wl.words.length, 0);
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

  test('fromString', () {
    WordList list = new  WordList.fromString("satu=one\ndua=two\n\ntiga=three");
    expect(list,w123);
  });

  test('asPersistentData', () {
    String data = w123.asPersistentData();
    WordList deserialised = new WordList.fromString(data);
    expect(w123, deserialised);
  });

  test('asPersistentData for empty', () {
    String data = new WordList.fromList([]).asPersistentData();
    WordList deserialised = new WordList.fromString(data);
    expect(deserialised.words, []);
  });
}