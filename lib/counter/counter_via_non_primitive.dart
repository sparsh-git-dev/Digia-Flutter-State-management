import 'dart:developer';

import 'package:digit/digia/digia.dart';
import 'package:digit/digia/digia_builder.dart';
import 'package:digit/digia/digia_exception.dart';
import 'package:flutter/material.dart';

import 'state/counter_state.dart';

class CounterPageViaNonPrimitive extends StatefulWidget {
  const CounterPageViaNonPrimitive({super.key});

  @override
  State<CounterPageViaNonPrimitive> createState() =>
      _CounterPageViaNonPrimitiveState();
}

class _CounterPageViaNonPrimitiveState
    extends State<CounterPageViaNonPrimitive> {
  late final DigiaStateManager<CounterState> counter;
  void _stateLogger<T>(T oldState, T newState) {
    log('State changed from $oldState to $newState');
  }

  void _stateValidator<T>(T oldState, T newState) {
    if (oldState == newState) {
      throw DigiaException('State cannot be same');
    }
  }

  @override
  void initState() {
    super.initState();
    counter =
        DigiaStateManager<CounterState>(const CounterState(0), onInit: () {
      print("-------------init--------------------");
    }, middlewares: [_stateLogger, _stateValidator]);
  }

  @override
  void dispose() {
    counter.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter App NON PRIMITIVE')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DigiaBuilder<CounterState>(
            instance: counter,
            builder: (BuildContext context, CounterState state) {
              return Text(
                'Counter State Value: ${state.value}',
                style: const TextStyle(fontSize: 24),
              );
            },
          ),
          const SizedBox(height: 100),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      counter.update(CounterState(counter.state.value + 1));
                    },
                    child: const Icon(Icons.add)),
              ),
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      counter.update(CounterState(counter.state.value - 1));
                    },
                    child: const Icon(Icons.remove)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
