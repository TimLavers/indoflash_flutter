import 'package:flutter/material.dart';
import 'package:flutter_app2/actions/actions.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/buttons.dart';
import 'package:flutter_app2/routes/routes.dart';
import 'package:flutter_app2/spec/spec.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

const CHAPTER_SELECTOR = 'Chapter Selector';

class ChapterSelector extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, ChaptersModel>(
        converter: (Store<AppState> store) => ChaptersModel(store),
        builder: (BuildContext context, ChaptersModel model) =>
            Scaffold(
              appBar: AppBar(title: Text(CHAPTER_SELECTOR)),
              body: ListView.builder(
                  itemBuilder: (BuildContext context, int index) =>
                      ChapterItem(model.title(index),
                              (index) {
                            model.chapterSelected(index);
                            Navigator.pushNamed(context, listSelector);
                          },
                          index),
                  itemCount: model.length),
              bottomNavigationBar: BottomNavigationBar(
                  fixedColor: Colors.black,
                  onTap: (int index) {
                    if (index == 0) {
                      Navigator.pushNamed(context, mainScreen);
                    } else {
                      Navigator.pushNamed(context, listSelector);
                    }
                  },
                  items: <BottomNavigationBarItem>[
                    createHomeNavigationButton(),
                    createWordListNavigationButton(),
                  ]),
            ),
      );
}

class ChaptersModel {
  Store<AppState> _store;
  List<ChapterSpec> _chapters;

  ChaptersModel(this._store) {
    _chapters = _store.state.chapterState.applicationSpec.chapters;//todo improve?
  }

  get length => _chapters.length;

  String title(int index) => _chapters[index].title;

  void chapterSelected(int index) =>
      _store.dispatch(new ChapterSelectedAction(index));
}

Key chapterItemKey(int index) => new Key("ChapterItem:$index");

class ChapterItem extends StatelessWidget {
  final String _title;
  final ChapterSelected _callback;
  final int _index;

  ChapterItem(this._title, this._callback, this._index);

  @override
  Widget build(BuildContext context) {
    return new ListTile(title: new Text(_title),
        onTap: () => _callback(_index),
        key: chapterItemKey(_index)
    );
  }
}