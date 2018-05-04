import 'package:flutter/material.dart';
import 'package:flutter_app2/actions/actions.dart';
import 'package:flutter_app2/keys/keys.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/buttons.dart';
import 'package:flutter_app2/routes/routes.dart';
import 'package:flutter_app2/vocab/word.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

const WORD_LIST_SELECTOR = 'Word List Selector';
const MAIN_SCREEN = 'IndoFlash';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, MainScreenModel>(
      converter: (Store<AppState> store) => MainScreenModel(store),
      builder: (BuildContext context, MainScreenModel model) => Scaffold(
            appBar: AppBar(
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
                      child: Text(MAIN_SCREEN,
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: <Widget>[
                      _ListNavigator(model),
                      ShuffleToggleButton(
                          model.state.listState, model.callbackForShuffleToggle)
                    ],
                  ),
                )
              ],
            ),
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

class _ListNavigator extends StatelessWidget {
  final MainScreenModel _model;

  const _ListNavigator(this._model);

  @override
  Widget build(BuildContext context) {
    if (_model.state.atEndOfCurrentList) {
      return RepeatListButton(_model.callbackForRepeat);
    } else {
      return ShowOrNextButton(_model.wordState, _model.callbackForNext);
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

class ShowOrNextButton extends StatelessWidget {
  final WordState _wordState;
  final VoidCallback _callback;

  const ShowOrNextButton(this._wordState, this._callback);

  @override
  Widget build(BuildContext context) => RaisedButton(
        onPressed: _callback,
        child: Text(_buttonText, key: showOrNextButtonKey),
      );

  String get _buttonText => _wordState.showDefinition ? 'Next' : 'Show';
}

class ShuffleToggleButton extends StatelessWidget {
  final ListState _listState;
  final VoidCallback _callback;

  const ShuffleToggleButton(this._listState, this._callback);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        key: shuffleToggleButtonKey, onPressed: _callback, child: _image);
  }

  Image get _image {
    AssetImage assetImage = _listState.shuffled
        ? AssetImage('images/ic_unshuffle.png')
        : AssetImage('images/ic_shuffle.png');
    return Image(image: assetImage, height: 24.0, width: 24.0);
  }

  String get _buttonText => _listState.shuffled ? 'Order' : 'Shuffle';
}

class RepeatListButton extends StatelessWidget {
  final VoidCallback _callback;

  const RepeatListButton(this._callback);

  @override
  Widget build(BuildContext context) => RaisedButton(
        onPressed: _callback,
        child: Text('Repeat List', key: repeateListButtonKey),
      );
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
