import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_hooks/flutter_hooks.dart'
    show use, useStream, Hook, HookState;

// flutter_redux_hooksパッケージ(MIT License)を参考に作成。
Store<S> useStore<S>() => use(_UseStoreHook());

class _UseStoreHook<S> extends Hook<Store<S>> {
  @override
  HookState<Store<S>, Hook<Store<S>>> createState() => _UseStoreHookState<S>();
}

class _UseStoreHookState<S> extends HookState<Store<S>, _UseStoreHook<S>> {
  @override
  Store<S> build(BuildContext context) => StoreProvider.of<S>(context);
}

typedef Dispatch = dynamic Function(dynamic action);
Dispatch useDispatch<S>() => useStore<S>().dispatch;

typedef Selector<State, Output> = Output Function(State state);
typedef EqualityFn<T> = bool Function(T a, T b);
Output? useSelector<State, Output>(Selector<State, Output> selector) {
  final store = useStore<State>();
  final snap = useStream<Output>(store.onChange.map(selector),
      initialData: selector(store.state));
  return snap.data;
}
