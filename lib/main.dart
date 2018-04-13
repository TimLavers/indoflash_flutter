import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/reducers/app_state_reducer.dart';
import 'package:flutter_app2/routes/routes.dart';
import 'package:flutter_app2/presentation/main_screen.dart';
import 'package:flutter_app2/presentation/word_list_selector.dart';

void main() => runApp(new IndoFlash());

class IndoFlash extends StatelessWidget {
  //Adapted from the Flutter initial app and
  //The Flutter Architecture Samples https://github.com/brianegan/flutter_architecture_samples.git

  final store = new Store<AppState>(appReducer, initialState: new AppState.showingWordList());

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        title: "IndoFlash Friday",
        theme: new ThemeData(
          primarySwatch: indoRed,
        ),
        routes: {
      IndoFlashRoutes.home: (context) {
            return new StoreBuilder<AppState>(
              builder: (context, store) {
                return new MainScreen();
              },
            );
          },
          IndoFlashRoutes.listSelector: (context) {
            return new StoreBuilder<AppState>(
              builder: (context, store) {
                return new WordListSelector();
              },
            );
          },
        },
      ),
    );
  }




//  @override
  Widget ___build(BuildContext context) {
    return new MaterialApp(
      title: 'IndoFlash',
      theme: new ThemeData(
        primarySwatch: indoRed,
      ),
      home: new WordListPage(title: 'IndoFlash'),
    );
  }
}

class fdfdIndoFlashRoutes {
  static final home = "/";
  static final listSelector = "/lists";
  static final chapterSelector = "/chapters";
}

class WordListPage extends StatefulWidget {
  WordListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WordListPageState createState() => new _WordListPageState();
}

class _WordListPageState extends State<WordListPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}

const MaterialColor indoRed = const MaterialColor(
  _indoRedPrimaryValue,
  const <int, Color>{
    50: const Color(0xFFFDE3E3),
    100: const Color(0xFFFBBBBB),
    200: const Color(0xFFF09090),
    300: const Color(0xFFF66464),
    400: const Color(0xFFF54242),
    500: const Color(_indoRedPrimaryValue),
    600: const Color(0xFFE51E1E),
    700: const Color(0xFFD21919),
    800: const Color(0xFFC01515),
    900: const Color(0xFFA10D0D),
  },
);
const int _indoRedPrimaryValue = 0xFFf32121;