import 'package:flutter/widgets.dart';
import 'digia.dart';

class DigiaBuilder<T> extends StatefulWidget {
  final DigiaStateManager<T> instance;
  final Widget Function(BuildContext context, T state) builder;

  const DigiaBuilder({
    required this.instance,
    required this.builder,
    super.key,
  });

  @override
  State<DigiaBuilder> createState() => _DigiaBuilderState<T>();
}

class _DigiaBuilderState<T> extends State<DigiaBuilder<T>> {
  late T _state;

  @override
  void initState() {
    super.initState();
    _state = widget.instance.state;
    widget.instance.addListener(_onStateChange);
  }

  @override
  void dispose() {
    widget.instance.removeListener(_onStateChange);
    super.dispose();
  }

  void _onStateChange() => setState(() => _state = widget.instance.state);

  @override
  Widget build(BuildContext context) => widget.builder(context, _state);
}
