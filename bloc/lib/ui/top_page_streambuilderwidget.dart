import 'package:flutter/material.dart';

import 'package:bloc/bloc/counter_logic.dart';

class TopPage extends StatefulWidget {
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  CounterLogic counterLogic;

  @override
  void initState() {
    super.initState();
    counterLogic = CounterLogic();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoc Simple Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _WidgetA(counterLogic),
          _WidgetB(),
          _WidgetC(counterLogic),
        ],
      ),
    );
  }
}

class _WidgetA extends StatelessWidget {
  final CounterLogic counterLogic;

  _WidgetA(this.counterLogic);

  @override
  Widget build(BuildContext context) {
    print('called _WidgetA#build()');
    return Center(
      child: StreamBuilder(
          stream: counterLogic.value,
          builder: (context, snapshot) {
            return Text(
              '${snapshot.data}',
              style: Theme.of(context).textTheme.display1,
            );
          }),
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
  final CounterLogic counterLogic;

  _WidgetC(this.counterLogic);
  @override
  Widget build(BuildContext context) {
    print('called _WidgetC#build()');
    return RaisedButton(
      onPressed: () => counterLogic.incrementCounter(),
      child: Icon(Icons.add),
    );
  }
}
