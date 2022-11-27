import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'reducers/sample.dart';
import 'middlewares/persister.dart';

final persistor = Persistor<SampleState>(
  stateToMap: (state) => state.toMap(),
  mapToState: (data) => SampleState.fromMap(data),
  storeKey: "sample",
  debounceDuration: const Duration(milliseconds: 500),
);

Future<SampleState> _loadState() async {
  final initialState = await persistor.load();
  return initialState ?? SampleState(counter: 0);
}

class SampleStoreProvider extends StatelessWidget {
  final Widget child;

  SampleStoreProvider({required this.child});

  Widget build(BuildContext context) {
    return FutureBuilder<SampleState>(
      future: _loadState(),
      builder: (BuildContext context, AsyncSnapshot<SampleState> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return CircularProgressIndicator();
        }

        return StoreProvider<SampleState>(
          store: Store<SampleState>(
            sampleReducer,
            initialState: snapshot.data!,
            middleware: [persistor.createMiddleware()],
          ),
          child: child,
        );
      },
    );
  }
}
