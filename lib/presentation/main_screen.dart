import 'package:flutter/material.dart';
import 'package:flutter_app2/actions/actions.dart';
import 'package:flutter_app2/keys/keys.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/buttons.dart';
import 'package:flutter_app2/routes/routes.dart';
import 'package:flutter_app2/vocab/word.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

const WORD_LIST_SELECTOR = 'List Selector';
const INDO_FLASH = 'IndoFlash';
const MAIN_SCREEN = 'Words';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, MainScreenModel>(
      converter: (Store<AppState> store) => MainScreenModel(store),
      builder: (BuildContext context, MainScreenModel model) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(),
                      margin: EdgeInsets.only(right: 10.0),
                      child: Image(
                          image: AssetImage('images/ic_launcher.png'),
                          height: 36.0,
                          width: 36.0)),
                  Container(
                      child: Text(INDO_FLASH,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 28.0,
                            color: Colors.white,
                          )),
                      color: Colors.black)
                ],
              ),
              backgroundColor: Colors.black,
            ),
            body: Column(
              children: [
                Container(
                  child: Center(
                    child: Text(
                      model.listName,
                      style: new TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 26.0,
                      ),
                    ),
                  ),
                  color: Colors.red,
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      child: WordDisplay(
                          model.word, model.wordState.showDefinition),
                      alignment: Alignment.topLeft,
                    )),
                Row(
                  children: <Widget>[
                    FlatButton(
                      child: Icon(Icons.arrow_upward),
                      onPressed: () {},
                    ),
                    FlatButton(
                      child: Icon(Icons.favorite),
                      onPressed: () {},
                    ),
                    shuffleToggleButton(model.state.listState, model.callbackForShuffleToggle),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                )
              ],
            ),
            floatingActionButton: ListNavigator(
                    model.state, model.callbackForNext, model.callbackForRepeat)
                .button(),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            bottomNavigationBar: BottomNavigationBar(
                fixedColor: Colors.black,
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

class ListNavigator {
  final Navigation _state;
  final VoidCallback _nextCallback;
  final VoidCallback _repeatCallback;

  const ListNavigator(this._state, this._nextCallback, this._repeatCallback);

  FloatingActionButton button() {
    if (_state.atEndOfCurrentList()) {
      return FloatingActionButton(
          key: navigateListButtonKey,
          child: Icon(Icons.repeat),
          onPressed: _repeatCallback);
    } else {
      return FloatingActionButton(
          key: navigateListButtonKey,
          child: Icon(Icons.play_arrow),
          onPressed: _nextCallback);
    }
  }
}

class WordDisplay extends StatelessWidget {
  final Word _word;
  final bool _showDef;

  const WordDisplay(this._word, this._showDef);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _createTextBox(_word.word, wordKey),
      _createTextBox(_definitionTextToShow, definitionKey),
    ]);
  }

  String get _definitionTextToShow => _showDef ? _word.definition : '';

  Widget _createTextBox(String text, Key key) => Expanded(
      flex: 1,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 20.0,
        ),
        key: key,
        textAlign: TextAlign.left,
      ));
}

FlatButton shuffleToggleButton(ListState listState, VoidCallback callback) {
  IconData iconToUse = listState.shuffled ? Icons.straighten : Icons.shuffle;
  return FlatButton(
      key: shuffleToggleButtonKey,
      child: Icon(iconToUse),
      onPressed: callback);
}

class MainScreenModel {
  final Store<AppState> _store;

  MainScreenModel(this._store);

  String get listName => _store.state.currentWordListTitle;

  int get index => _store.state.wordState.index;

  WordState get wordState => _store.state.wordState;

  Word get word => _store.state.currentWord;

  AppState get state => _store.state; //todo test

  VoidCallback get callbackForShuffleToggle =>
      () => _store.dispatch(ToggleShuffle());

  VoidCallback get callbackForNext => () => _store.dispatch(WordNext());

  VoidCallback get callbackForRepeat => () => _store.dispatch(RepeatList());
}
