import 'package:flutter/material.dart';
import 'package:flutter_app2/presentation/chapter_selector.dart';
import 'package:flutter_app2/presentation/main_screen.dart';

BottomNavigationBarItem createHomeNavigationButton() =>
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text(MAIN_SCREEN)
    );

BottomNavigationBarItem createWordListNavigationButton() =>
    BottomNavigationBarItem(
        icon: Icon(Icons.list),
        title: Text(WORD_LIST_SELECTOR)
    );

BottomNavigationBarItem createChapterListNavigationButton() =>
    BottomNavigationBarItem(
        icon: Icon(Icons.folder),
        title: Text(CHAPTER_SELECTOR)
    );
