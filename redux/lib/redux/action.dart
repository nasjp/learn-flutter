class LoadingAction {}

class LoadingCompleteAction {}

class CountUpAction {
  final int counter;

  const CountUpAction(this.counter);
}

class CountUpSucceededAction {
  final int increaseCount;

  CountUpSucceededAction(this.increaseCount);
}
