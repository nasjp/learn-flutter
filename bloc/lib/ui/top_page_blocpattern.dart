import 'package:flutter/material.dart';

import 'package:bloc/bloc/counter_bloc.dart';
import 'package:bloc/repository/count_repository.dart';
import 'package:bloc/ui/widgets/loading_widget.dart';

class TopPage extends StatefulWidget {
  final CountRepository countRepository;

  TopPage(this.countRepository);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  CounterBloc counterBloc;

  @override
  void initState() {
    super.initState();
    counterBloc = CounterBloc(widget.countRepository);
  }

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: const Text('BLoc Simple Demo'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _WidgetA(counterBloc),
              _WidgetB(),
              _WidgetC(counterBloc),
            ],
          ),
        ),
        LoadingStreamWidget(counterBloc.isLoading),
      ],
    );
  }
}

class _WidgetA extends StatelessWidget {
  final CounterBloc counterBloc;

  _WidgetA(this.counterBloc);

  @override
  Widget build(BuildContext context) {
    print('called _WidgetA#build()');
    return Center(
      child: StreamBuilder(
          stream: counterBloc.value,
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
  final CounterBloc counterBloc;

  _WidgetC(this.counterBloc);
  @override
  Widget build(BuildContext context) {
    print('called _WidgetC#build()');
    return RaisedButton(
      onPressed: () => counterBloc.incrementCounter(),
      child: Icon(Icons.add),
    );
  }
}
