import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sabak08/constants/api_keys.dart';

class WeatherUIView extends StatefulWidget {
  WeatherUIView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WeatherUIViewState createState() => _WeatherUIViewState();
}

class _WeatherUIViewState extends State<WeatherUIView> {
  Future<http.Response> getWeather(String city) async {
    try {
      final client = http.Client();

      String weatherUrl =
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=${ApiKeys.openweather_key}";

      Uri url = Uri.parse(weatherUrl);

      final response = await client.get(url);

      print('response.statusCode: ${response.statusCode} ');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        return null;
      }
    } catch (error) {
      print('Try-Catch Error: $error');
    }
  }

  Future<http.Response> getWeather2(String city) {
    final client = http.Client();

    String weatherUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=${ApiKeys.openweather_key}";

    Uri url = Uri.parse(weatherUrl);

    return client.get(url).then((response) {
      if (response.statusCode == 200) {
        return response;
      } else {
        return null;
      }
    }).onError((error, stackTrace) {
      print('ERROR: $error');
      print('StackTrace: $stackTrace');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather UI'),
      ),
      body: FutureBuilder<http.Response>(
        future: getWeather2('New York'),
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
