import 'package:flutter/material.dart';

import 'ui/top_page.dart';
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
      home: TopPage(CountRepository()),
    );
  }
}
