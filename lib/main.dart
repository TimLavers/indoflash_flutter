import 'package:flutter/material.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/presentation/main_screen.dart';
import 'package:flutter_app2/presentation/chapter_selector.dart';
import 'package:flutter_app2/presentation/word_list_selector.dart';
import 'package:flutter_app2/reducers/app_state_reducer.dart';
import 'package:flutter_app2/routes/routes.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<AppState>(appReducer, initialState: AppState.initial());
  runApp(IndoFlash(store));
}

class IndoFlash extends StatelessWidget {
  //Adapted from the Flutter initial app and
  //The Flutter Architecture Samples
  //https://github.com/brianegan/flutter_architecture_samples.git

  final Store<AppState> store;

  IndoFlash(this.store);

  @override
  Widget build(BuildContext context) =>
     StoreProvider<AppState>(
      store: this.store,
      child:
      MaterialApp(
        title: "IndoFlash",
        theme: new ThemeData(primarySwatch: indoRed),
        home: MainScreen(),
        routes: {
          mainScreen: (context) => MainScreen(),
          listSelector: (context) => WordListSelector(),
          chapterSelector: (context) => ChapterSelector(),
        },
      ),
    );
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