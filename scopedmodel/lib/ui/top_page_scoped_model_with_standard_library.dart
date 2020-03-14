import 'package:flutter/material.dart';

import 'package:scopedmodel/values/counter_value.dart';
import 'package:scopedmodel/values/loading_value.dart';

class TopPage extends StatelessWidget {
  final ICountRepository _repository;
  TopPage(this._repository);

  @override
  Widget build(BuildContext context) {
    return _HomePage(
      repository: _repository,
      loadingValue: LoadingValue(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ValueNotifier Demo'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _WidgetA(),
            _WidgetB(),
            _WidgetC(),
          ],
        ),
      ),
    );
  }
}

class _HomePage extends StatefulWidget {
  final ICountRepository repository;
  final LoadingValue loadingValue;

  _HomePage({
    Key key,
    this.repository,
    this.loadingValue,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _HomePageState createState() => _HomePageState();

  static _HomePageState of(BuildContext context, {bool rebuild = true}) {
    if (rebuild) {
      return (context.dependOnInheritedWidgetOfExactType<_MyInheritedWidget>())
          .data;
    }
    return (context
            .getElementForInheritedWidgetOfExactType<_MyInheritedWidget>()
            .widget as _MyInheritedWidget)
        .data;
  }
}

class _HomePageState extends State<_HomePage> {
  CounterValue counterValue;

  @override
  void initState() {
    super.initState();
    counterValue = CounterValue(widget.repository, widget.loadingValue);
  }

  @override
  Widget build(BuildContext context) {
    return _MyInheritedWidget(
      data: this,
      child: Stack(
        children: <Widget>[
          widget.child,
          _LoadingWidget(widget.loadingValue),
        ],
      ),
    );
  }
}

class _MyInheritedWidget extends InheritedWidget {
  _MyInheritedWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final _HomePageState data;

  @override
  bool updateShouldNotify(_MyInheritedWidget oldWidget) {
    return true;
  }
}

class _WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called _WidgetA#build()");
    final _HomePageState state = _HomePage.of(context, rebuild: false);
    return Center(
      child: ValueListenableBuilder<int>(
        valueListenable: state.counterValue.valueNotifier,
        builder: (_context, count, _child) =>
            Text('$count', style: Theme.of(context).textTheme.display1),
      ),
    );
  }
}

class _WidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('called _WidgetB#build()');
    return Text('I am a widget that will not be rebuilt');
  }
}

class _WidgetC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('called _WidgetC#build()');
    final _HomePageState state = _HomePage.of(context, rebuild: false);
    return RaisedButton(
      onPressed: () => state.counterValue.incrementCounter(),
      child: Icon(Icons.add),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  final LoadingValue loadingValue;

  const _LoadingWidget(this.loadingValue);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: loadingValue.valueNotifier,
      builder: (_context, isLoading, _child) {
        return isLoading
            ? const DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0x44000000),
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
