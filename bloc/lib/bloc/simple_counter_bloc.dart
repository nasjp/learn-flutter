import 'dart:async';

import 'package:bloc/bloc/simple_loading_bloc.dart';

abstract class ICountRepository {
  Future<int> fetch();
}

class CounterBloc {
  final ICountRepository _repository;
  final LoadingBloc _loadingBloc;

  final _valueController = StreamController<int>();

  Stream<int> get value => _valueController.stream;

  int _counter = 0;

  CounterBloc(this._repository, this._loadingBloc) {
    _valueController.sink.add(_counter);
  }

  void incrementCounter() async {
    _loadingBloc.loading(true);

    _counter += await _repository
        .fetch()
        .whenComplete(() => _loadingBloc.loading(false));

    _valueController.sink.add(_counter);
  }

  void dispose() => _valueController.close();
}
