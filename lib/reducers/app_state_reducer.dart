//Adapted from https://github.com/brianegan/flutter_architecture_samples.git

import 'package:flutter_app2/models/app_state.dart';

AppState appReducer(AppState state, Screen screen) {
  return state.copyWith(screen: screen);
}