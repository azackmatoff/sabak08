import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sabak08/constants/api_keys.dart';
import 'package:sabak08/services/weather_services.dart';
import 'package:sabak08/views/weather_model_view.dart';
import 'package:sabak08/views/weather_view.dart';

import 'repository/weather_repo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REST API TEST',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherModelView(),
    );
  }
}
