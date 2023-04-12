// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'sensor_data.dart';

class UserSensor extends StatefulWidget {
  const UserSensor({Key? key}) : super(key: key);
  @override
  State<UserSensor> createState() => _UserSensorState();
}

class _UserSensorState extends State<UserSensor> {
  String _displayText = 'Results';
  final _database = FirebaseDatabase.instance.ref();
  late StreamSubscription _sensorStream;

  @override
  initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    _sensorStream = _database.child('sensor_data').onValue.listen((event) {
      final dynamic data = event.snapshot.value;
      Map<String, dynamic> json = {};
      if (data is Map) {
        json = Map<String, dynamic>.from(data);
      } else if (data is String) {
        json = jsonDecode(data);
      }
      final sensorData = SensorData.fromRTDB(json);
      setState(() {
        _displayText = sensorData.fancyResults();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Data'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_displayText),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    _sensorStream.cancel();
    super.deactivate();
  }
}
