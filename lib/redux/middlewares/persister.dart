import 'dart:async';
import 'dart:convert';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

// redux_persistパッケージ(MIT License)を参考に作成。
class Persistor<T> {
  final Map<String, dynamic> Function(T state) stateToMap;
  final T Function(Map<String, dynamic> data) mapToState;
  final String storeKey;
  final Duration? debounceDuration;
  Timer? _timer;

  Persistor({
    required this.stateToMap,
    required this.mapToState,
    required this.storeKey,
    this.debounceDuration,
  });

  Middleware<T> createMiddleware() {
    return (Store<T> store, dynamic action, NextDispatcher next) async {
      next(action);

      if (debounceDuration != null) {
        if (_timer?.isActive ?? false) {
          _timer?.cancel();
        }
        _timer = Timer(debounceDuration!, () => _save(store.state));
      } else {
        _save(store.state);
      }
    };
  }

  Future<T?> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString(storeKey);
    if (data == null) return null;

    return mapToState(json.decode(data));
  }

  Future<void> _save(T state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(storeKey, json.encode(stateToMap(state)));
  }
}
