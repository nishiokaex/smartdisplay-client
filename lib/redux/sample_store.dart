import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useRef, HookWidget;
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

class SampleStoreProvider extends HookWidget {
  final Widget child;

  SampleStoreProvider({super.key, required this.child});

  Widget build(BuildContext context) {
    final initialState = useRef<Future<SampleState>>(_loadState());

    return FutureBuilder<SampleState>(
      future: initialState.value,
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
