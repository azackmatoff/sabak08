import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sabak08/repository/weather_repo.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({Key key}) : super(key: key);

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
      ),
      body: FutureBuilder<http.Response>(
        future: weatherRepo.getWeatherData('Chicago'),
        builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
          print('snapshot.connectionState: ${snapshot.connectionState}');
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = json.decode(snapshot.data.body);

            print('data[weather].runtimeType: ${data['weather'].runtimeType}');
            print('data[base].runtimeType: ${data['base'].runtimeType}');

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'City: ${data['name']}',
                  ),
                  Text(
                    'F: ${data['main']['temp']}',
                  ),
                  Text(
                    'Weather main: ${data['weather'][0]['id'].toString()}',
                  ),
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text('Data null'),
            );
          }
        },
      ),
    );
  }
}
