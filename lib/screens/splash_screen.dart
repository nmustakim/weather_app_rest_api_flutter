import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_rest_api_flutter/controller/location_controller.dart';
import 'package:weather_app_rest_api_flutter/screens/weather_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final locationController = Get.put(LocationController());
  @override
  @override
  Widget build(BuildContext context) {
    return Obx(() => locationController.isLoaded.value
        ? const WeatherHome()
        : Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue, Colors.deepPurple],
                ),
              ),
              child:  Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Stack(
                      children: [
                        Icon(
                          Icons.cloud,
                          size: 100,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.sunny,
                          size: 50,
                          color: Colors.orangeAccent,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Weather App',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          await locationController.getUserLocation();
                        },
                        icon: const Icon(Icons.refresh,color: Colors.white,)),

                  ],
                ),
              ),
            ),
          ));
  }
}
