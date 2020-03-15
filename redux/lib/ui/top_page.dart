import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:reduxx/redux/state.dart';
import 'package:reduxx/redux/action.dart';
import 'package:reduxx/redux/reducer.dart';
import 'package:reduxx/redux/middleware.dart';

class TopPage extends StatelessWidget {
  final ICountRepository _repository;

  final Store<AppState> store;

  TopPage(this._repository)
      : store = Store<AppState>(
          appStateReducer,
          initialState: const AppState(),
          middleware: counterMiddleware(_repository),
        );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Text('Redux Demo'),
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
          const LoadingWidget(),
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
      child: StoreConnector<AppState, int>(
          converter: (store) => store.state.counter,
          builder: (context, counter) {
            return Text(
              '$counter',
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
      onPressed: () {
        var store = StoreProvider.of<AppState>(context);
        store.dispatch(CountUpAction(store.state.counter));
      },
      child: Icon(Icons.add),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      distinct: true,
      converter: (Store<AppState> store) => store.state.isLoading,
      builder: (context, isLoading) {
        return (isLoading)
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
