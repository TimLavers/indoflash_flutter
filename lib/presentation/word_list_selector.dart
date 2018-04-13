import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_app2/models/app_state.dart';
import 'package:flutter_app2/routes/routes.dart';

class  WordListSelector extends StatelessWidget {

  WordListSelector({Key key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Word List Selector"),
      ),
      body:
      new Text(
        'This is just some text!',
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, IndoFlashRoutes.home);
        },
        tooltip: 'Main Screen',
        child: new Icon(Icons.account_balance),
      ),
    );


//    return new Text("Word List Selector Screen");
  }
}