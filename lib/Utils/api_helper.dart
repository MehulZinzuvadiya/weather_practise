import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_practise/Model/weather_model.dart';

class ApiHelper {
  WeatherModel? weatherModel;

  Future<WeatherModel?> weatherApi(String city) async {
    String link =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=70153a5abbeef9b7f51dd75e7ecca858";
    Uri uri = Uri.parse(link);
    var response = await http.get(uri);
    var json = jsonDecode(response.body);
    weatherModel = WeatherModel.fromJson(json);
    return weatherModel;
  }
}
