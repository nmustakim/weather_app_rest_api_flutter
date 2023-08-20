import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_rest_api_flutter/controller/app_controller.dart';
import 'package:weather_app_rest_api_flutter/screens/weather_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final appController = Get.put(AppController());
  @override


  @override
  Widget build(BuildContext context) {
    return Obx(() =>appController.isLoaded.value? const WeatherHome(): Scaffold(

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.deepPurple],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 16),
              Text(
                'Weather App',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    )
    );
  }
}
