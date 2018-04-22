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

  ChapterSelector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ChaptersModel>(
        converter: (Store<AppState> store) {
          return new ChaptersModel(store);
        },
        builder: (BuildContext context, ChaptersModel model) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text(CHAPTER_SELECTOR),
            ),
            body:
            new ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                new ChapterItem(
                    model.title(index), (index) => model.chapterSelected(index),
                    index),
                itemCount: model.length),
            bottomNavigationBar: new BottomNavigationBar(
                onTap: (int index) {
                  if (index == 0) {
                    Navigator.pushNamed(context, IndoFlashRoutes.home);
                  } else {
                    Navigator.pushNamed(context, IndoFlashRoutes.listSelector
                    );
                  }
                },
                items: <BottomNavigationBarItem>[
                  createHomeNavigationButton(),
                  createWordListNavigationButton(),
                ]),
          );
        });
  }
}

class ChaptersModel {
  Store<AppState> store;
  List<ChapterSpec> chapters;

  ChaptersModel(this.store) {
    chapters = store.state.applicationSpec.chapters;
  }

  get length => chapters.length;

  String title(int index) => chapters[index].title;

  void chapterSelected(int index) =>
      store.dispatch(new ChapterSelectedAction(index));
}

class ChapterItem extends StatelessWidget {
  final String title;
  final ChapterSelected callback;
  final int index;

  ChapterItem(this.title, this.callback, this.index);

  @override
  Widget build(BuildContext context) {
    return new ListTile(title: new Text(title),
        onTap: () => callback(index));
  }
}