import 'package:flutter/material.dart';
import 'package:flutter_app2/keys/keys.dart';
import 'package:flutter_app2/presentation/buttons.dart';
import 'package:flutter_app2/routes/routes.dart';
import 'package:flutter_app2/keys/keys.dart';

const WORD_LIST_SELECTOR = 'Word List Selector';
const MAIN_SCREEN = 'Main Screen';

class MainScreen extends StatelessWidget {
  MainScreen() : super(key: IndoFlashKeys.homeScreen);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("main screeeen"),
      ),
      body:
        new Text(
              'This is some text',
      ),
      bottomNavigationBar: new BottomNavigationBar(
          onTap: (int index) {
            if (index == 0) {
              Navigator.pushNamed(context, IndoFlashRoutes.listSelector);
            } else {
              Navigator.pushNamed(context, IndoFlashRoutes.chapterSelector);
            }
          },
          items: <BottomNavigationBarItem>[
            createWordListNavigationButton(),
            createChapterListNavigationButton(),
          ]),
    );
  }
}