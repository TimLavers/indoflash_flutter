import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app2/models/app_state.dart';

main() {
  group('WordState', () {
    test('constructor', () {
      WordState state = WordState(5, true);
      expect(state.index, 5);
      expect(state.showDefinition, true);

      state = WordState(2, false);
      expect(state.index, 2);
      expect(state.showDefinition, false);
    });

    test('initial', () {
      WordState state = WordState.initial();
      expect(state.index, 0);
      expect(state.showDefinition, false);
    });

    test('for next', () {
      WordState state = WordState.initial();
      WordState forNext = state.forNext();
      expect(forNext.index, 0);
      expect(forNext.showDefinition, true);

      forNext = forNext.forNext();
      expect(forNext.index, 1);
      expect(forNext.showDefinition, false);

      forNext = forNext.forNext();
      expect(forNext.index, 1);
      expect(forNext.showDefinition, true);

      forNext = forNext.forNext();
      expect(forNext.index, 2);
      expect(forNext.showDefinition, false);
    });

    test('constructor with index', () {
      WordState state = WordState.withIndex(5);
      expect(state.index, 5);
      expect(state.showDefinition, false);
    });

    test('toggleDefinition', () {
      WordState state = WordState.withIndex(5);
      WordState toggled = state.toggleShowDefinition();
      expect(toggled.index, state.index);
      expect(toggled.showDefinition, !state.showDefinition);
      WordState toggledAgain = toggled.toggleShowDefinition();
      expect(toggledAgain.index, state.index);
      expect(toggledAgain.showDefinition, state.showDefinition);
    });

    test('==', () {
      WordState stateA = WordState(5, true);
      WordState stateB = WordState(5, true);
      WordState stateC = WordState(5, false);
      WordState stateD = WordState(2, true);
      WordState stateE = WordState(2, false);
      expect(stateA == stateB, true);
      expect(stateA == stateC, false);
      expect(stateA == stateD, false);
      expect(stateA == stateE, false);
    });

    test('hash code', () {
      WordState stateA = WordState(5, true);
      WordState stateB = WordState(5, true);
      expect(stateA.hashCode, stateB.hashCode);
    });
  });
}