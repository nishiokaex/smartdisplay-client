import 'package:flutter/material.dart';
import './redux/sample_store.dart';
import './containers/viewer_root.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleStoreProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ViewerRoot(),
      ),
    );
  }
}
