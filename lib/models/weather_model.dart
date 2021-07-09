import 'package:sabak08/helpers/calvin_to_celcius.dart';

class WeatherModel {
  final int id;
  final String cityName;
  final num windSpeed;
  final double celcius;

  WeatherModel({this.id, this.cityName, this.windSpeed, this.celcius});

  factory WeatherModel.fromMap(Map<String, dynamic> map) => WeatherModel(
        id: map['id'],
        cityName: map['name'],
        windSpeed: map['wind']['speed'] ?? 0.0,
        celcius: TempHelper().calvinToCelcius(map['main']['temp']),
      );
}
