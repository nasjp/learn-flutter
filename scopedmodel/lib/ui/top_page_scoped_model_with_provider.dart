import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:scopedmodel/values/counter_value.dart';
import 'package:scopedmodel/values/loading_value.dart';

class TopPage extends StatelessWidget {
  final ICountRepository _repository;
  TopPage(this._repository);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoadingValueNotifier>(
          create: (_) => LoadingValueNotifier(),
        ),
        ChangeNotifierProvider<CounterValueNotifier>(
          create: (context) => CounterValueNotifier(
            _repository,
            Provider.of<LoadingValueNotifier>(context, listen: false),
          ),
        ),
      ],
      child: Stack(
        children: <Widget>[
          Scaffold(
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
          const _LoadingWidget(),
        ],
      ),
    );
  }
}

class _WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("called _WidgetA#build()");
    return Center(
      child: ValueListenableBuilder<int>(
        valueListenable:
            Provider.of<CounterValueNotifier>(context, listen: false),
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
    return RaisedButton(
      onPressed: () => Provider.of<CounterValueNotifier>(context, listen: false)
          .incrementCounter(),
      child: Icon(Icons.add),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable:
          Provider.of<LoadingValueNotifier>(context, listen: false),
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
