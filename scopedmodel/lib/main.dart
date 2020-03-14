import 'package:flutter/material.dart';

// import 'package:scopedmodel/ui/top_page_scoped_model.dart';
// import 'package:scopedmodel/ui/top_page_scoped_model_with_standard_library.dart';
import 'package:scopedmodel/ui/top_page_scoped_model_with_provider.dart';

import 'package:scopedmodel/repository/count_repository.dart';

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
