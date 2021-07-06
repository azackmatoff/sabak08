import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sabak08/constants/api_keys.dart';
import 'package:sabak08/helpers/client_helper.dart';
import 'package:sabak08/models/weather_model.dart';

class WeatherServices {
  Future<String> getCityName(double latitude, double longitude) async {
    final endpoint =
        'weather?lat=$latitude&lon=$longitude&appid=${ApiKeys.openweather_key}';

    final response = await clientHelper.get(endpoint);
  }

  Future<http.Response> getWeatherData(String city) async {
    String endpoint = "weather?q=$city&appid=${ApiKeys.openweather_key}";
    return await clientHelper.get(endpoint);
  }

  Future<WeatherModel> getWeatherModel(String city) async {
    String endpoint = "weather?q=$city&appid=${ApiKeys.openweather_key}";
    http.Response response = await clientHelper.get(endpoint);

    Map<String, dynamic> data = json.decode(response.body);

    WeatherModel weatherModel = WeatherModel.fromMap(data);

    return weatherModel;
  }
}

final WeatherServices weatherServices = WeatherServices();
