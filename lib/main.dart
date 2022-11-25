import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:state_notifier_ex/providers/bg_color.dart';

import 'providers/counter.dart';
import 'providers/customer_level.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<BgColor, BgColorState>(
            create: (context) => BgColor()),
        StateNotifierProvider<Counter, CounterState>(
            create: (context) => Counter()),
        StateNotifierProvider<CustomerLevel, Level>(
            create: (context) => CustomerLevel())
      ],
      child: MaterialApp(
        title: 'State Notifier',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorState = context.watch<BgColorState>();
    final counterState = context.watch<CounterState>();
    final levelState = context.watch<Level>();

    return Scaffold(
      backgroundColor: levelState == Level.bronze
          ? Colors.white
          : levelState == Level.silver
              ? Colors.grey
              : Colors.yellow,
      appBar: AppBar(
        backgroundColor: colorState.color,
        title: Text('StateNotifier'),
      ),
      body: Center(
        child: Text(
          '${counterState.counter}',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<Counter>().increment();
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(
            width: 10.0,
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<BgColor>().changeColor();
            },
            tooltip: 'Change Color',
            child: Icon(
              Icons.color_lens_outlined,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }
}
