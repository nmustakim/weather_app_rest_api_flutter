import 'package:http/http.dart' as http;
import '../model/weather_model.dart';

getCurrentWeather(lat, long) async {
  String url = "http://api.weatherapi.com/v1/forecast.json?key=1c0bba5a869743feb3923820231708&q=$lat,$long&days=1&aqi=yes&alerts=yes";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = weatherModelFromJson(response.body.toString());
    print(data.forecast?.forecastday?.first.day?.maxtempC);
    return data;
  }
}

