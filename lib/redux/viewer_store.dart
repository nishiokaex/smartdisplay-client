import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useRef, HookWidget;
import 'package:firebase_auth/firebase_auth.dart';
import 'reducers/viewer.dart';
import './states/viewer.dart';

Future<ViewerState> loadState() async {
  // 匿名ログイン
  final FirebaseAuth auth = FirebaseAuth.instance;
  final UserCredential result = await auth.signInAnonymously();
  String? uid = result.user?.uid;

  if (uid == null) {
    return ViewerState(
      isLoading: false,
      hasError: true,
    );
  } else {
    return ViewerState(
      deviceId: uid,
      isLoading: false,
      hasError: false,
      dashboardId: "00d9bf0d-45df-4d45-8390-f45d6d03a3f5",
    );
  }
}

class ViewerStoreProvider extends HookWidget {
  final Widget child;

  ViewerStoreProvider({required this.child});

  Widget build(BuildContext context) {
    final initialState = useRef<Future<ViewerState>>(loadState());

    return FutureBuilder<ViewerState>(
      future: initialState.value,
      builder: (BuildContext context, AsyncSnapshot<ViewerState> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(
                  "Error: ${snapshot.error}",
                ),
              ),
            ),
          );
        }

        return StoreProvider<ViewerState>(
          store: Store<ViewerState>(
            viewerReducer,
            initialState: snapshot.data!,
            middleware: [],
          ),
          child: child,
        );
      },
    );
  }
}
