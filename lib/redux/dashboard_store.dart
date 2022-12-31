import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useRef, HookWidget;
import '../services/firestore.dart';
import 'reducers/dashbaord.dart';
import 'states/dashbaord.dart';

Future<DashboardState> loadState(String dashboardId) async {
  DocumentSnapshot snapshot =
      await FirestoreService.select("Dashboard", dashboardId);
  Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
  return DashboardState.fromMap(map);
}

class DashbaordStoreProvider extends HookWidget {
  final Widget child;
  final String dashboardId;

  DashbaordStoreProvider({required this.child, required this.dashboardId});

  Widget build(BuildContext context) {
    final initialState = useRef<Future<DashboardState>>(loadState(dashboardId));

    return FutureBuilder<DashboardState>(
      future: initialState.value,
      builder: (BuildContext context, AsyncSnapshot<DashboardState> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        return StoreProvider<DashboardState>(
          store: Store<DashboardState>(
            dashboardReducer,
            initialState: snapshot.data!,
            middleware: [],
          ),
          child: child,
        );
      },
    );
  }
}
