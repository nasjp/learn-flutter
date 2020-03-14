import 'package:scoped_model/scoped_model.dart';

import 'loading_model.dart';

abstract class ICountRepository {
  Future<int> fetch();
}

class CounterModel extends Model {
  final ICountRepository _repository;
  final LoadingModel _loadingModel;

  int _counter = 0;

  int get counter => _counter;

  CounterModel(this._repository, this._loadingModel);

  void incrementCounter() async {
    _loadingModel.loading(true);
    var increaseCount = await _repository
        .fetch()
        .whenComplete(() => _loadingModel.loading(false));
    _counter += increaseCount;

    notifyListeners();
  }
}
