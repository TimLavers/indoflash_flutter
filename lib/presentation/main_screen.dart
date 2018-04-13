import 'package:flutter/material.dart';
import 'package:flutter_app2/keys/keys.dart';
import 'package:flutter_app2/routes/routes.dart';
import 'package:flutter_app2/keys/keys.dart';

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
      floatingActionButton: new FloatingActionButton(
        key: IndoFlashKeys.wordListSelectorLauncher,
        onPressed: (){
          Navigator.pushNamed(context, IndoFlashRoutes.listSelector);
        },
        tooltip: 'Word List Selector',
        child: new Icon(Icons.account_balance),
      ),
    );
  }
}