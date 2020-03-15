import 'package:redux/redux.dart';

import 'state.dart';
import 'action.dart';

AppState appStateReducer(AppState state, action) => AppState(
      isLoading: loadingReducer(state.isLoading, action),
      counter: counterReducer(state.counter, action),
    );

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, LoadingAction>((state, action) => true),
  TypedReducer<bool, LoadingCompleteAction>((state, action) => false),
]);

final counterReducer = combineReducers<int>([
  TypedReducer<int, CountUpSucceededAction>(
      (state, action) => state + action.increaseCount),
]);
