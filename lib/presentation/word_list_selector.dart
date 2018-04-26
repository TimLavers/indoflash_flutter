import 'package:flutter/material.dart';
import 'package:flutter_app2/actions/actions.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/buttons.dart';
import 'package:flutter_app2/presentation/main_screen.dart';
import 'package:flutter_app2/routes/routes.dart';
import 'package:flutter_app2/spec/spec.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class WordListSelector extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, WordListsModel>(
      converter: (Store<AppState> store) => WordListsModel(store),
      builder: (BuildContext context, WordListsModel model) =>
          Scaffold(
            appBar: AppBar(title: Text(WORD_LIST_SELECTOR)),
            body: ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    WordListItem(model.title(index),
                            (index) {
                          model.wordListSelected(index);
                          Navigator.pushNamed(context, home);
                        }, index),
                itemCount: model.length),
            bottomNavigationBar: BottomNavigationBar(
                onTap: (int index) {
                  if (index == 0) {
                    Navigator.pushNamed(context, home);
                  } else {
                    Navigator.pushNamed(
                        context, chapterSelector);
                  }
                },
                items: <BottomNavigationBarItem>[
                  createHomeNavigationButton(),
                  createChapterListNavigationButton(),
                ]),
          ),
    );
  }
}

class WordListsModel {
  Store<AppState> _store;
  List<WordListSpec> _wordLists;

  WordListsModel(this._store) {
    _wordLists = _store.state.currentChapter.wordLists;
  }

  get length => _wordLists.length;

  String title(int index) => _wordLists[index].title;

  void wordListSelected(int index) {
    _store.dispatch(new WordListSelectedAction(index));
  }
}

Key wordListItemKey(int index) => new Key("WordListItem:$index");

class WordListItem extends StatelessWidget {
  //todo refactor
  final String _title;
  final WordListSelected _callback;
  final int _index;

  WordListItem(this._title, this._callback, this._index);

  @override
  Widget build(BuildContext context) {
    return new ListTile(title: new Text(_title),
        onTap: () => _callback(_index),
        key: wordListItemKey(_index)
    );
  }
}