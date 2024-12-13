final class CounterState {
  final int _state;
  const CounterState(this._state);
  int get value => _state;

  factory CounterState._copyWith(int newValue) => CounterState(newValue);

  CounterState increment() => CounterState._copyWith(_state + 1);
  CounterState decrement() => CounterState._copyWith(_state - 1);
}
