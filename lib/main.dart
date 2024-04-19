import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Timer? _timer;
  bool _isTimer = false;
  int _hh = 0;
  int _mm = 0;
  int _ss = 0;
  int _ms = 0;

  void _togleTimer() {
    if (!_isTimer) {
      _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        _counter++;
        _hh = (_counter ~/ 360000);
        _mm = ((_counter % 360000) ~/ 6000);
        _ss = ((_counter % 360000) % 6000) ~/ 100;
        _ms = ((_counter % 360000) % 6000) % 100;
        setState(() {});
      });
    } else {
      _timer?.cancel();
    }
    _isTimer = !_isTimer;
    setState(() {});
  }

  void _resetTimer() {
    _timer?.cancel();
    _counter = _hh = _mm = _ss = _ms = 0;
    _isTimer = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('STOP WATCH'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${_hh.toString().padLeft(2, '0')}:${_mm.toString().padLeft(2, '0')}:${_ss.toString().padLeft(2, '0')}.${_ms.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _togleTimer,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(_isTimer ? 'STOP' : 'START'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text('RESET'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
