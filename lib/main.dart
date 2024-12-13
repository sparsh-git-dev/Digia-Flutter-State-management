import 'package:digit/counter/counterViaNonPrimitive.dart';
import 'package:flutter/material.dart';

import 'counter/counterViaPrimitives.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Counter App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const CounterPageViaPrimitive()));
                  },
                  child: const Text("State via primitives")),
            ),
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) =>
                                const CounterPageViaNonPrimitive()));
                  },
                  child: const Text("State via  non primitives")),
            )
          ],
        ),
      ),
    );
  }
}
