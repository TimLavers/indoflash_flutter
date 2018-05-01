import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app2/models/app_state.dart';

main() {
  group('ListState', () {
    test('constructor', () {
      ListState state = ListState(true, true);
      expect(state.showingFavourites, true);
      expect(state.shuffled, true);

      state = ListState(false, false);
      expect(state.showingFavourites, false);
      expect(state.shuffled, false);
    });

    test('initial', () {
      ListState state = ListState.initial();
      expect(state.showingFavourites, false);
      expect(state.shuffled, false);
    });

    test('toggle shuffle', () {
      ListState state = ListState(true, true);
      ListState toggled = state.toggleShuffle();
      expect(toggled.shuffled, false);
      expect(toggled.showingFavourites, true);
      ListState doubleToggled = toggled.toggleShuffle();
      expect(doubleToggled.shuffled, true);
      expect(doubleToggled.showingFavourites, true);
    });

    test('toggle showing favourites', () {
      ListState state = ListState(true, true);
      ListState toggled = state.toggleShowFavourites();
      expect(toggled.shuffled, true);
      expect(toggled.showingFavourites, false);
      ListState doubleToggled = toggled.toggleShowFavourites();
      expect(doubleToggled.shuffled, true);
      expect(doubleToggled.showingFavourites, true);
    });

    test('==', () {
      ListState stateA = ListState(true, true);
      ListState stateB = ListState(true, false);
      ListState stateC = ListState(false, true);
      ListState stateD = ListState(false, false);
      ListState stateE = ListState(true, true);
      expect(stateA==stateB, false);
      expect(stateA==stateC, false);
      expect(stateA==stateD, false);
      expect(stateA==stateE, true);
    });

    test('hash code', () {
      ListState stateA = ListState(true, false);
      ListState stateB = ListState(true, false);
      expect(stateA.hashCode, stateB.hashCode);
    });

    test('hash code', () {
      ListState stateA = ListState(true, false);
      expect(stateA.toString(), 'ListState{shuffled: true, showingFavourites: false}');
    });
  });
}