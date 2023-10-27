import 'package:flutter/material.dart';

class CounterPage extends StatelessWidget {
  final int counter;
  final VoidCallback onAddTap;

  const CounterPage({super.key, required this.counter, required this.onAddTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddTap,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}