import "package:bloc/bloc/simple_counter_bloc.dart";

class CountRepository implements ICountRepository {
  Future<int> fetch() {
    return Future.delayed(const Duration(seconds: 1)).then((_) {
      return 1;
    });
  }
}
