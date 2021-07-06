import 'package:http/http.dart' as http;
import 'package:sabak08/enums/database_type.dart';
import 'package:sabak08/models/weather_model.dart';
import 'package:sabak08/services/weather_fake_data.dart';
import 'package:sabak08/services/weather_services.dart';

class WeatherRepo {
  final DatabaseType databaseType = DatabaseType.API;

  Future<String> getCityName(double latitude, double longitude) async {
    return await weatherServices.getCityName(latitude, longitude);
  }

  Future<http.Response> getWeatherData(String city) async {
    return await weatherServices.getWeatherData(city);
  }

  Future<WeatherModel> getWeatherModel(String city) async {
    if (databaseType == DatabaseType.FAKE) {
      return weatherFakeData.getFakeWeatherModel(city);
    } else {
      return await weatherServices.getWeatherModel(city);
    }
  }
}

final WeatherRepo weatherRepo = WeatherRepo();
