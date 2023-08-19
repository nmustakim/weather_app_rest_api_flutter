import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_rest_api_flutter/screens/weather_home.dart';

import 'controller/app_controller.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController appController = Get.put(AppController());
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: WeatherHome());
  }
}

