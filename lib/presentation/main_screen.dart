import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_app2/keys/keys.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/buttons.dart';
import 'package:flutter_app2/routes/routes.dart';
import 'package:flutter_app2/vocab/word.dart';
import 'package:flutter_app2/vocab/word_list.dart';
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
                      child: Text(MAIN_SCREEN,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
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
                      child: FutureBuilder<Word>(
                        future: model.word,
                        builder: (BuildContext context,
                            AsyncSnapshot<Word> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Text('...');
                            case ConnectionState.waiting:
                              return Text('...');
                            default:
                              if (snapshot.hasError)
                                return Text('Error: ${snapshot.error}');
                              else
                                return WordDisplay(snapshot.data, true);
                          }
                        },
                      ),
                      alignment: Alignment.topLeft,
                    )),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: ShowOrNextButton(model.wordState, (){}),
                )],
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

class WordDisplay extends StatelessWidget {
  final Word _word;
  final bool _showDef;

  const WordDisplay(this._word, this._showDef);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
      ));
}

class ShowOrNextButton extends StatelessWidget {
  final WordState _wordState;
  final ShowOrNextButtonClicked _callback;

  const ShowOrNextButton(this._wordState, this._callback);

  @override
  Widget build(BuildContext context) =>
      RaisedButton(
        onPressed: _callback,
        child: Text(_buttonText, key: showOrNextButtonKey),
      );

  String get _buttonText => _wordState.showDefinition ? 'Next' : 'Show';
}

class MainScreenModel {
  final Store<AppState> _store;

  MainScreenModel(this._store);

  String get listName => _store.state.currentWordList.title;

  int get index => _store.state.wordState.index;

  WordState get wordState => _store.state.wordState;

  Future<Word> get word async {
//    WordListSpec listSpec = store.state.currentWordList;
//    String fileName = listSpec.fileName;
    String assetName = 'resources/lessons/lesson1';
    String data = await rootBundle.loadString(assetName, cache: true);
    WordList wordList = WordList.fromString(data);
    return wordList.words[index];
  }
}
