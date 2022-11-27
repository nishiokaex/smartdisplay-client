import 'package:redux/redux.dart';
import '../actions/increment.dart';

class SampleState {
  final int counter;

  SampleState({
    required this.counter,
  });

  SampleState copyWith({
    int? counter,
  }) {
    return SampleState(
      counter: counter ?? this.counter,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'counter': counter,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    int? counter = map['counter'];

    return SampleState(
      counter: counter ?? 0,
    );
  }
}

final sampleReducer = combineReducers<SampleState>([
  TypedReducer<SampleState, IncrementAction>(_incrementAction),
]);

SampleState _incrementAction(SampleState oldState, IncrementAction action) {
  return oldState.copyWith(counter: oldState.counter + 1);
}
