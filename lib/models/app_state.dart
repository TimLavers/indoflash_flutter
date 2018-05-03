//Adapted from https://github.com/brianegan/flutter_architecture_samples.git
import 'package:flutter_app2/spec/spec.dart';
import 'package:flutter_app2/vocab/word.dart';
import 'package:flutter_app2/vocab/word_list.dart';
import 'package:meta/meta.dart';

typedef void ChapterSelected(int index);
typedef void WordListSelected(int index);

/// The state of the application. This consists of the chapter,
/// the word list, the index of the currently showing word,
/// and so on. The state is broken into sub-objects.
/// The state includes a list of words to present. This may
/// differ from the list obtained from the current selected
/// lesson due to shuffling. However, this list does not
/// form part of the identity of the state as it does
/// not contain any information that is not derived
/// from the other data.
@immutable
class AppState {
  final ChapterState chapterState;
  final WordState wordState;
  final ListState listState;
  final List<Word> _words;

  AppState.initial()
      : chapterState = ChapterState.start(),
        wordState = WordState.initial(),
        listState = ListState.initial(),
        _words = ChapterState.start().currentWordList.wordList.words;

  //A state for the given chapter and word states,
  //with the list state indicating the given shuffled
  //flag and not showing favourites.
  AppState(this.chapterState, this.wordState, bool shuffled)
      : listState = ListState(shuffled, false),
        _words = shuffled
            ? chapterState.currentWordList.wordList.shuffled().words
            : chapterState.currentWordList.wordList.words;

  AppState._copy(
      this.chapterState, this.wordState, this.listState, this._words);

  //A new state in which the chosen list is the first word
  //list in the given chapter, the word state is at the
  //beginning, and the list is shuffled iff the current
  //list is.
  AppState forChapter(int index) {
    ChapterState cs = ChapterState.withIndexedChapter(index);
    WordList wordsRaw = cs.currentWordList.wordList;
    WordState ws = WordState(0, false); //Start of the list.
    ListState newListState = ListState(listState.shuffled, false);
    WordList words = listState.shuffled ? wordsRaw.shuffled() : wordsRaw;
    return AppState._copy(cs, ws, newListState, words.words);
  }

  //A new state showing the indexed list from
  //the current chapter. The word state is at
  //the beginning, and the list is shuffled
  //according to the state of the current list.
  AppState forListInCurrentChapter(int index) {
    ChapterState cs = chapterState.copyWithIndexedWordList(index);
    WordList wordsRaw = cs.currentWordList.wordList;
    WordState ws = WordState(0, false); //Start of the list.
    ListState ls = ListState(listState.shuffled, false); //Not favourites.
    WordList words = listState.shuffled ? wordsRaw.shuffled() : wordsRaw;
    return AppState._copy(cs, ws, ls, words.words);
  }

  AppState forNext() => atEndOfCurrentList
      ? AppState._copy(chapterState, WordState.initial(), listState, _words)
      : AppState._copy(chapterState, wordState.forNext(), listState, _words);

  AppState forRepeat() {
    if (listState.shuffled) {
      return AppState._copy(chapterState, WordState(0, false), listState,
          WordList.fromList(_words).shuffled().words);
    }
    return AppState._copy(chapterState, WordState(0, false), listState, _words);
  }

  AppState forToggleShuffle() {
    ListState newListState = listState.toggleShuffle();
    //If it was shuffled, we get the straight list.
    //If it was straight, we get a shuffled version.

    List<Word> newList = _currentWordList.wordList.words;
    if (newListState.shuffled) {
      newList = _currentWordList.wordList.shuffled().words;
    }
//    List<Word> newList = newListState.shuffled ?
//    _currentWordList.wordList.shuffled().words :
//    _currentWordList.wordList.words;
    //We go back to the beginning of the list.
    WordState start = WordState(0, false);
    return AppState._copy(chapterState, start, newListState, newList);
  }

  String get currentWordListTitle => chapterState.currentWordList.title;

  WordListSpec get _currentWordList => chapterState.currentWordList;

  Word get currentWord => _words[wordState.index];

  int get _lengthOfCurrentWordList => _currentWordList.wordList.words.length;

  ChapterSpec get currentChapter => chapterState.currentChapter;

  ApplicationSpec get applicationSpec => chapterState.applicationSpec;

  bool get atEndOfCurrentList =>
      wordState.index == (_lengthOfCurrentWordList - 1) &&
      wordState.showDefinition;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          chapterState == other.chapterState &&
          wordState == other.wordState &&
          listState == other.listState;

  @override
  int get hashCode => chapterState.hashCode ^ wordState.hashCode;
}

@immutable
class ChapterState {
  final applicationSpec = ChapterStructure().applicationSpec;
  final ChapterSpec currentChapter;
  final WordListSpec currentWordList;

  ChapterState.start()
      : currentChapter = ChapterStructure().chapter1,
        currentWordList = ChapterStructure().chapter1.wordLists[0];

  ChapterState.withIndexedChapter(int index)
      : currentChapter = ChapterStructure().applicationSpec.chapters[index],
        currentWordList =
            ChapterStructure().applicationSpec.chapters[index].wordLists[0];

  ChapterState(this.currentChapter, this.currentWordList);

  ChapterState copyWithIndexedWordList(int wordListIndex) =>
      ChapterState(currentChapter, currentChapter.wordLists[wordListIndex]);

  @override
  int get hashCode => currentChapter.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterState &&
          runtimeType == other.runtimeType &&
          currentWordList == other.currentWordList &&
          currentChapter == other.currentChapter;

  @override
  String toString() => 'AppState{chapter: ${currentChapter.title}}';
}

@immutable
class WordState {
  final int index;
  final bool showDefinition;

  WordState.initial()
      : index = 0,
        showDefinition = false;

  WordState(this.index, this.showDefinition);

  WordState.withIndex(this.index) : showDefinition = false;

  WordState toggleShowDefinition() => WordState(index, !showDefinition);

  WordState forNext() {
    //todo test - what to do at end??
    int newIndex = showDefinition ? index + 1 : index;
    bool newShowDefinition = !showDefinition;
    return WordState(newIndex, newShowDefinition);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordState &&
          runtimeType == other.runtimeType &&
          index == other.index &&
          showDefinition == other.showDefinition;

  @override
  int get hashCode => index.hashCode ^ showDefinition.hashCode;
}

@immutable
class ListState {
  final bool shuffled;
  final bool showingFavourites;

  ListState(this.shuffled, this.showingFavourites); //todo make these named??

  ListState.initial()
      : shuffled = false,
        showingFavourites = false;

  ListState toggleShuffle() =>
      ListState(!this.shuffled, this.showingFavourites);

  ListState toggleShowFavourites() =>
      ListState(this.shuffled, !this.showingFavourites);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListState &&
          runtimeType == other.runtimeType &&
          shuffled == other.shuffled &&
          showingFavourites == other.showingFavourites;

  @override
  int get hashCode => shuffled.hashCode ^ showingFavourites.hashCode;

  @override
  String toString() =>
      'ListState{shuffled: $shuffled, showingFavourites: $showingFavourites}';
}
