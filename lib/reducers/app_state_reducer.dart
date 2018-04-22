import 'package:flutter_app2/actions/actions.dart';
import 'package:flutter_app2/models/app_state.dart';

AppState appReducer(AppState state, action) {
  return (action as StateSwitchAction).invoke(state);
}