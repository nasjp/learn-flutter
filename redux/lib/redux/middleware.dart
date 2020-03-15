import 'package:redux/redux.dart';

import 'state.dart';
import 'action.dart';

abstract class ICountRepository {
  Future<int> fetch();
}

List<Middleware<AppState>> counterMiddleware(ICountRepository repository) =>
    [TypedMiddleware<AppState, CountUpAction>(_fetch(repository))];

void Function(
  Store<AppState> store,
  CountUpAction action,
  NextDispatcher next,
) _fetch(
  ICountRepository repository,
) =>
    (store, action, next) {
      next(action);
      next(LoadingAction());
      repository.fetch().then((increaseCount) {
        store.dispatch(CountUpSucceededAction(increaseCount));
      }).catchError((error) {
        print(error);
      }).whenComplete(() {
        next(LoadingCompleteAction());
      });
    };
