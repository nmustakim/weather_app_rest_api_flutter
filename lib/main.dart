import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_rest_api_flutter/screens/splash_screen.dart';
import 'package:weather_app_rest_api_flutter/screens/weather_home.dart';

import 'controller/location_controller.dart';

void main() {

  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const GetMaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}

