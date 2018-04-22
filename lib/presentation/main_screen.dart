import 'package:flutter/material.dart';
import 'package:flutter_app2/keys/keys.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/buttons.dart';
import 'package:flutter_app2/routes/routes.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


const WORD_LIST_SELECTOR = 'Word List Selector';
const MAIN_SCREEN = 'Main Screen';

class MainScreen extends StatelessWidget {
  MainScreen() : super(key: IndoFlashKeys.homeScreen);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, MainScreenModel>(
        converter: (Store<AppState> store) {
          return new MainScreenModel(store);
        },
        builder: (BuildContext context, MainScreenModel model) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text(MAIN_SCREEN),
            ),
            body: new Text(model.chapterTitle),
            bottomNavigationBar: new BottomNavigationBar(
                onTap: (int index) {
                  if (index == 0) {
                    Navigator.pushNamed(context, IndoFlashRoutes.listSelector);
                  } else {
                    Navigator.pushNamed(
                        context, IndoFlashRoutes.chapterSelector);
                  }
                },
                items: <BottomNavigationBarItem>[
                  createWordListNavigationButton(),
                  createChapterListNavigationButton(),
                ]),
          );
        });
  }
}

class MainScreenModel {
  final Store<AppState> store;

  MainScreenModel(this.store);

  get chapterTitle => store.state.currentChapter.title;
}