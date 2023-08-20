import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';


import '../api_service/weather_service.dart';

class AppController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await getUserLocation();

  }


  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  var isLoaded = false.obs;

  getUserLocation() async {
    bool isLocationEnabled;
    LocationPermission userPermission;

    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return Get.snackbar('Error', 'Location is not enabled');

    }

    userPermission = await Geolocator.checkPermission();
    if (userPermission == LocationPermission.deniedForever) {

      return  Get.snackbar('Error', 'Permission is denied forever');
    } else if (userPermission == LocationPermission.denied) {
      userPermission = await Geolocator.requestPermission();
      if (userPermission == LocationPermission.denied) {
      return  Get.snackbar('Error', 'Permission is denied');

      }
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      latitude.value = value.latitude;
      longitude.value = value.longitude;
      isLoaded.value = true;
    });
  }
}
