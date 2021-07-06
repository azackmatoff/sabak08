import 'package:sabak08/models/weather_model.dart';

class WeatherFakeData {
  Future<WeatherModel> getFakeWeatherModel(String city) async {
    return await Future.delayed(Duration(seconds: 1), () {
      WeatherModel weatherModel = WeatherModel(
          id: 1000, cityName: city, windSpeed: 1.5, celcius: 11.05);
      return weatherModel;
    });
  }
}

final WeatherFakeData weatherFakeData = WeatherFakeData();
