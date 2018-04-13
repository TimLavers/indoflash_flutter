import 'package:flutter_app2/models/app_state.dart';

class SwitchStateAction {
  final Screen toSwitchTo;

  SwitchStateAction(this.toSwitchTo);

  @override
  String toString() {
    return 'SwitchStateAction{toSwitchTo: $toSwitchTo}';
  }
}