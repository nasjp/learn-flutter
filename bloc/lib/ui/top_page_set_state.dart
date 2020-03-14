import 'package:flutter/material.dart';
import 'package:bloc/repository/count_repository.dart';
import 'package:bloc/ui/widgets/loading_widget.dart';

class TopPage extends StatefulWidget {
  final CountRepository repository;

  TopPage(this.repository);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  int _counter = 0;
  bool _isLoading = false;

  void _incrementCounter() async {
    setState(() => _isLoading = true);
    widget.repository.fetch().then((increaseCount) {
      setState(() => _counter = increaseCount);
    }).whenComplete(() {
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: const Text('setState Demo'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _WidgetA(_counter),
              _WidgetB(),
              _WidgetC(_incrementCounter),
            ],
          ),
        ),
        LoadingWidget(_isLoading),
      ],
    );
  }
}

class _WidgetA extends StatelessWidget {
  final int counter;

  _WidgetA(this.counter);

  @override
  Widget build(BuildContext context) {
    print('called _WidgetA#build()');
    return Center(
      child: Text(
        '$counter',
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
  final void Function() incrementCounter;

  _WidgetC(this.incrementCounter);

  @override
  Widget build(BuildContext context) {
    print('called _WidgetC#build()');
    return RaisedButton(
      onPressed: () => incrementCounter(),
      child: Icon(Icons.add),
    );
  }
}
