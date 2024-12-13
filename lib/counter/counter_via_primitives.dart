import 'dart:developer';

import 'package:flutter/material.dart';

import '../digia/digia.dart';
import '../digia/digia_builder.dart';
import '../digia/digia_exception.dart';

class CounterPageViaPrimitive extends StatefulWidget {
  const CounterPageViaPrimitive({super.key});

  @override
  State<CounterPageViaPrimitive> createState() =>
      _CounterPageViaPrimitiveState();
}

class _CounterPageViaPrimitiveState extends State<CounterPageViaPrimitive> {
  late final DigiaStateManager<int> counter;
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
    counter = DigiaStateManager<int>(0, onInit: () {
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
      appBar: AppBar(title: const Text('Counter App PRIMITIVE ')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DigiaBuilder<int>(
            instance: counter,
            builder: (BuildContext context, int state) {
              return Text(
                'Counter State Value: $state',
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
                      counter.update(counter.state + 1);
                    },
                    child: const Icon(Icons.add)),
              ),
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      counter.update(counter.state - 1);
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
