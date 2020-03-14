import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bloc/bloc/simple_counter_bloc.dart';
import 'package:bloc/bloc/simple_loading_bloc.dart';

class TopPage extends StatelessWidget {
  final ICountRepository _repository;

  TopPage(this._repository);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoadingBloc>(
          create: (_) => LoadingBloc(),
          dispose: (_, bloc) => bloc.dispose(),
        ),
        Provider<CounterBloc>(
          create: (context) => CounterBloc(
              _repository, Provider.of<LoadingBloc>(context, listen: false)),
          dispose: (_, bloc) => bloc.dispose(),
        ),
      ],
      child: Stack(
        children: <Widget>[
          Scaffold(
              appBar: AppBar(
                title: const Text('BLoc Demo'),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _WidgetA(),
                  _WidgetB(),
                  _WidgetC(),
                ],
              )),
          const LoadingStreamWidget(),
        ],
      ),
    );
  }
}

class _WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('called _WidgetA#build()');
    return Center(
      child: StreamBuilder(
          stream: Provider.of<CounterBloc>(context, listen: false).value,
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
  @override
  Widget build(BuildContext context) {
    print('called _WidgetC#build()');
    return RaisedButton(
      onPressed: () =>
          Provider.of<CounterBloc>(context, listen: false).incrementCounter(),
      child: Icon(Icons.add),
    );
  }
}

class LoadingStreamWidget extends StatelessWidget {
  const LoadingStreamWidget();

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<LoadingBloc>(context);
    return StreamBuilder<bool>(
        initialData: false,
        stream: bloc.value,
        builder: (context, snapshot) {
          return snapshot.data
              ? const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0x44000000),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox.shrink();
        });
  }
}
