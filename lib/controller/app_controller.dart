import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../api_service/weather_service.dart';

class AppController extends GetxController {
  @override
  void onInit() async {
    await getUserLocation();
    currentWeatherData = getCurrentWeather(latitude.value, longitude.value);
    super.onInit();
  }

  dynamic currentWeatherData;

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  var isLoaded = false.obs;

  getUserLocation() async {
    bool isLocationEnabled;
    LocationPermission userPermission;

    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      throw Exception("Location is not enabled");
    }

    userPermission = await Geolocator.checkPermission();
    if (userPermission == LocationPermission.deniedForever) {
      throw Exception("Permission is denied forever");
    } else if (userPermission == LocationPermission.denied) {
      userPermission = await Geolocator.requestPermission();
      if (userPermission == LocationPermission.denied) {

        throw Exception("Permission is denied");

      }
    }

    try {
      Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      double latitude = currentPosition.latitude;
      double longitude = currentPosition.longitude;

      print("Latitude: $latitude, Longitude: $longitude");
    } catch (e) {
      print("Error getting location: $e");
    }
  }
}
