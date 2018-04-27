import 'package:flutter/material.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/buttons.dart';
import 'package:flutter_app2/routes/routes.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

const WORD_LIST_SELECTOR = 'Word List Selector';
const MAIN_SCREEN = 'Main Screen';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, MainScreenModel>(
      converter: (Store<AppState> store) => MainScreenModel(store),
      builder: (BuildContext context, MainScreenModel model) =>
          Scaffold(
            appBar: AppBar(title: Text(MAIN_SCREEN)),
            body: Text(model.wordList),
            bottomNavigationBar: new BottomNavigationBar(
                onTap: (int index) {
                  if (index == 0) {
                    Navigator.pushNamed(context, listSelector);
                  } else {
                    Navigator.pushNamed(context, chapterSelector);
                  }
                },
                items: <BottomNavigationBarItem>[
                  createWordListNavigationButton(),
                  createChapterListNavigationButton(),
                ]),
          ),
    );
  }
}

class MainScreenModel {
  final Store<AppState> store;

  MainScreenModel(this.store);

  get listName => store.state.currentWordList.title;

//  get word =>
}