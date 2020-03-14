import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:scopedmodel/models/counter_model.dart';
import 'package:scopedmodel/models/loading_model.dart';

class TopPage extends StatelessWidget {
  final ICountRepository _repository;
  TopPage(this._repository);

  final LoadingModel _loadingModel = LoadingModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<LoadingModel>(
      model: _loadingModel,
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Text('Scoped Model Demo'),
            ),
            body: ScopedModel<CounterModel>(
              model: CounterModel(
                _repository,
                _loadingModel,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _WidgetA(),
                  _WidgetB(),
                  _WidgetC(),
                ],
              ),
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
      child:
          ScopedModelDescendant<CounterModel>(builder: (context, child, model) {
        return Text(
          '${model.counter}',
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
          ScopedModel.of<CounterModel>(context, rebuildOnChange: false)
              .incrementCounter(),
      child: Icon(Icons.add),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (context, child, LoadingModel model) {
        return (model.value)
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
