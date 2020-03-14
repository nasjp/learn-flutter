import 'package:flutter/material.dart';

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _HomePage(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('setState Demo'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
  _HomePage({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _HomePageState createState() => _HomePageState();

  static _HomePageState of(BuildContext context, String aspect) =>
      InheritedModel.inheritFrom<_MyInheritedWidget>(context, aspect: aspect)
          .data;
}

class _HomePageState extends State<_HomePage> {
  int counter = 0;

  void _incrementCounter() {
    setState(() => counter++);
  }

  @override
  Widget build(BuildContext context) {
    return _MyInheritedWidget(
      data: this,
      child: widget.child,
    );
  }
}

class _MyInheritedWidget extends InheritedModel {
  _MyInheritedWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final _HomePageState data;

  @override
  bool updateShouldNotify(_MyInheritedWidget oldWidget) => true;

  bool updateShouldNotifyDependent(_MyInheritedWidget oldWidget, Set aspects) =>
      aspects.contains('A');
}

class _WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('called _WidgetA#build()');
    final _HomePageState state = _HomePage.of(context, 'A');

    return Center(
      child: Text(
        '${state.counter}',
        style: Theme.of(context).textTheme.display1,
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
    final _HomePageState state = _HomePage.of(context, 'C');
    return RaisedButton(
      onPressed: () => state._incrementCounter(),
      child: Icon(Icons.add),
    );
  }
}
