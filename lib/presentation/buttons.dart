import 'package:flutter/material.dart';
import 'package:flutter_app2/presentation/chapter_selector.dart';
import 'package:flutter_app2/presentation/main_screen.dart';
import 'package:flutter_app2/presentation/word_list_selector.dart';

BottomNavigationBarItem createHomeNavigationButton() {
  return new BottomNavigationBarItem (
      icon: new Icon(Icons.home),
      title: new Text(MAIN_SCREEN)
    );
}

BottomNavigationBarItem createWordListNavigationButton() {
  return new BottomNavigationBarItem (
      icon: new Icon(Icons.add_call),
      title: new Text(WORD_LIST_SELECTOR)
    );
}

BottomNavigationBarItem createChapterListNavigationButton() {
  return new BottomNavigationBarItem (
      icon: new Icon(Icons.featured_video),
      title: new Text(CHAPTER_SELECTOR)
    );
}