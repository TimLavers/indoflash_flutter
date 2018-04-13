import 'package:meta/meta.dart';

@immutable
class Word {
  final String word;
  final String definition;

  Word(this.word, this.definition);
}