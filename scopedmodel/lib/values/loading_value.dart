import 'package:flutter/material.dart';

class LoadingValue {
  final valueNotifier = ValueNotifier<bool>(false);

  loading(bool isLoading) {
    valueNotifier.value = isLoading;
  }
}

class LoadingValueNotifier extends ValueNotifier<bool> {
  LoadingValueNotifier() : super(false);

  loading(bool isLoading) {
    super.value = isLoading;
  }
}
