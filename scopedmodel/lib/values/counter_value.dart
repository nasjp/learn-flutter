import 'package:flutter/material.dart';

import 'loading_value.dart';

abstract class ICountRepository {
  Future<int> fetch();
}

class CounterValue {
  final ICountRepository _repository;
  final LoadingValue _loadingValue;

  CounterValue(this._repository, this._loadingValue);

  final valueNotifier = ValueNotifier<int>(0);

  void incrementCounter() async {
    _loadingValue.loading(true);
    valueNotifier.value += await _repository
        .fetch()
        .whenComplete(() => _loadingValue.loading(false));
  }
}

class CounterValueNotifier extends ValueNotifier<int> {
  final ICountRepository _repository;
  final LoadingValueNotifier _loadingValueNotifier;

  CounterValueNotifier(this._repository, this._loadingValueNotifier) : super(0);

  void incrementCounter() async {
    _loadingValueNotifier.loading(true);
    super.value += await _repository
        .fetch()
        .whenComplete(() => _loadingValueNotifier.loading(false));
  }
}
