import 'package:flutter/material.dart';

// import 'ui/top_page_set_state.dart';
// import 'ui/top_page_inheritedwidget.dart';
// import 'ui/top_page_inheritedmodel.dart';
// import 'ui/top_page_streambuilderwidget.dart';
// import 'ui/top_page_blocpattern.dart';
import 'ui/top_page_blocpattern_with_provider.dart';
import 'repository/count_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  final CountRepository _repository = CountRepository();
  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
              title: const Text("bloc pattern with provider の場合"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopPage(_repository),
                      fullscreenDialog: true,
                    ));
              })
        ],
      ),
    );
  }
}
