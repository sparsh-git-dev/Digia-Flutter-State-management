import 'package:digit/digia/digia.dart';
import 'package:flutter/widgets.dart';

class StateProvider<T> extends InheritedWidget {
  final DigiaStateManager<T> manager;

  const StateProvider({
    required this.manager,
    required super.child,
    super.key,
  });

  static DigiaStateManager<T>? of<T>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<StateProvider<T>>()
        ?.manager;
  }

  @override
  bool updateShouldNotify(StateProvider oldWidget) =>
      manager != oldWidget.manager;
}
