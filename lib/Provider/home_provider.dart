import 'package:flutter/material.dart';
import 'package:weather_practise/Utils/api_helper.dart';
import '../Model/weather_model.dart';

class HomeProvider extends ChangeNotifier {
  WeatherModel? w1;
  String city="india";

  Future<WeatherModel?> getWeatherData(String city) async {
    w1 = await ApiHelper().weatherApi(city);
    return w1;
  }
  void changeLocation(String location)
  {
    city=location;
    notifyListeners();
  }
}
