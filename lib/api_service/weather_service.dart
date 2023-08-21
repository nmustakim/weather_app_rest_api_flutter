import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/weather_model.dart';


getCurrentWeather(lat, long) async {
  String url = "http://api.weatherapi.com/v1/forecast.json?key=1c0bba5a869743feb3923820231708&q=$lat,$long&days=7&aqi=yes&alert=yes";
  var res = await http.get(Uri.parse(url));
  if (res.statusCode == 200) {
    print(res.statusCode);
    print(res.body);
    var json = jsonDecode(res.body);
    var data = WeatherModel.fromJson(json);
    return data;
  }
  else{
    print(res.statusCode);
  }
}
getWeatherByCity(String city) async {
  String url = "http://api.weatherapi.com/v1/forecast.json?key=1c0bba5a869743feb3923820231708&q=$city&days=7&aqi=yes&alert=yes";
  var res = await http.get(Uri.parse(url));
  if (res.statusCode == 200) {
    print(res.statusCode);
    print(res.body);
    var json = jsonDecode(res.body);
    var data = WeatherModel.fromJson(json);
    return data;
  }
  else{
    print(res.statusCode);
  }
}


