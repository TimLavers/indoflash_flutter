import 'package:meta/meta.dart';

@immutable
class Word {
  final String word;
  final String definition;

  Word(this.word, this.definition);

  @override
  String toString() {
    return 'Word{word: $word, definition: $definition}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Word &&
              runtimeType == other.runtimeType &&
              word == other.word &&
              definition == other.definition;

  @override
  int get hashCode =>
      word.hashCode ^
      definition.hashCode;

}