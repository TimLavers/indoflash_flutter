import 'package:flutter/material.dart';
import 'package:flutter_app2/presentation/buttons.dart';
import 'package:flutter_app2/presentation/main_screen.dart';
import 'package:flutter_app2/routes/routes.dart';

class WordListSelector extends StatelessWidget {

  WordListSelector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(WORD_LIST_SELECTOR),
      ),
      body:
      new Text(
        'This is just some text!',
      ),
      bottomNavigationBar: new BottomNavigationBar(
          onTap: (int index) {
            if (index == 0) {
              Navigator.pushNamed(context, IndoFlashRoutes.home);
            } else {
              Navigator.pushNamed(context, IndoFlashRoutes.chapterSelector);
            }
          },
          items: <BottomNavigationBarItem>[
            createHomeNavigationButton(),
            createChapterListNavigationButton(),
          ]),
    );
  }
}