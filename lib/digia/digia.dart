import 'dart:developer';

import 'digia_exception.dart';

typedef StateChangeListener = void Function();

abstract interface class _BaseStateManager<T> {
  T get state;

  void Function()? onInit;

  void update(T newState, {bool notify = true});

  void addListener(StateChangeListener listener);

  void removeListener(StateChangeListener listener);

  void dispose();

  void Function()? onDispose;
}

enum StateManagerStatus { idle, updating, error }

class DigiaStateManager<T> implements _BaseStateManager<T> {
  T _state;
  final List<Function(T oldState, T newState)>? middlewares;
  DigiaStateManager(this._state,
      {this.onInit, this.onDispose, this.middlewares}) {
    onInit?.call();
    log("StateManager instance initialized");
  }

  final List<StateChangeListener> _listeners = [];
  bool _isDisposed = false;
  StateManagerStatus _status = StateManagerStatus.idle;

  @override
  T get state => _state;

  StateManagerStatus get status => _status;

  @override
  void update(T newState, {bool notify = true}) {
    if (_isDisposed) {
      throw DigiaException('Attempted to update a disposed instance.');
    }
    try {
      _status = StateManagerStatus.updating;
      for (final middleware in middlewares ?? []) {
        middleware(_state, newState);
      }
      _state = newState;

      if (notify) _notifyListeners();

      _status = StateManagerStatus.idle;
    } catch (e) {
      _status = StateManagerStatus.error;
      rethrow;
    }
  }

  @override
  void addListener(StateChangeListener listener) {
    if (_isDisposed) return;
    if (!_listeners.contains(listener)) _listeners.add(listener);
  }

  @override
  void removeListener(StateChangeListener listener) {
    if (_isDisposed) return;
    _listeners.remove(listener);
  }

  void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  @override
  void dispose() {
    if (_isDisposed) return;
    _isDisposed = true;
    _listeners.clear();
    onDispose?.call();
    log('State Manager instance disposed for state: ${_state.runtimeType}');
  }

  void delete() {
    dispose();
    log('State Manager instance deleted for state: ${_state.runtimeType}');
  }

  bool get isDisposed => _isDisposed;

  int get listenerCount => _listeners.length;

  @override
  void Function()? onInit;

  @override
  void Function()? onDispose;
}
