import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
//import 'package:flutter_hooks/flutter_hooks.dart';
import './redux/reducers/sample.dart';
import './redux/sample_store.dart';
import './redux/actions/increment.dart';

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
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StoreBuilder<SampleState>(
              builder: (BuildContext context, Store<SampleState> store) {
                int counter = store.state.counter;
                return Text(
                  'The button has been pushed this many times: $counter',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: StoreConnector<SampleState, VoidCallback>(
        converter: (store) {
          return () => store.dispatch(IncrementAction());
        },
        builder: (context, callback) {
          return FloatingActionButton(
            // Attach the `callback` to the `onPressed` attribute
            onPressed: callback,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
