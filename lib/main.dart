import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Compass(),
        ),
      ),
    );
  }
}

class Compass extends StatefulWidget {
  const Compass({super.key});

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  double? _direction;
  late StreamSubscription<CompassEvent> _compassSubscription;

  @override
  void initState() {
    super.initState();
    _compassSubscription = FlutterCompass.events!.listen((CompassEvent event) {
      setState(() {
        _direction = event.heading;
      });
    });
  }

  @override
  void dispose() {
    _compassSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compass Example'),
      ),
      body: Center(
        child: Text('Current Direction: ${_direction?.toStringAsFixed(2)}°'),
      ),
    );
  }
}
