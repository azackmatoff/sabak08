import 'package:flutter/material.dart';
import 'package:sabak08/models/weather_model.dart';
import 'package:sabak08/repository/weather_repo.dart';

//OOP = Object Oriented Programming

class WeatherModelView extends StatefulWidget {
  const WeatherModelView({Key key}) : super(key: key);

  @override
  _WeatherModelViewState createState() => _WeatherModelViewState();
}

class _WeatherModelViewState extends State<WeatherModelView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Model View'),
      ),
      body: FutureBuilder<WeatherModel>(
        future: weatherRepo.getWeatherModel('Bishkek'),
        builder: (BuildContext context, AsyncSnapshot<WeatherModel> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            WeatherModel weatherModel = snapshot.data;

            print('weatherModel: ${weatherModel.runtimeType}');

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'City: ${weatherModel.cityName}',
                  ),
                  Text(
                    'Celcius: ${weatherModel.celcius}',
                  ),
                  Text(
                    'Wind speed: ${weatherModel.windSpeed}',
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
