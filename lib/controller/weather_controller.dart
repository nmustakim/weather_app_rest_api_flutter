import 'package:get/get.dart';
import 'package:weather_app_rest_api_flutter/controller/location_controller.dart';

import '../api_service/weather_service.dart';
import '../model/weather_model.dart';

class WeatherController extends GetxController {
  Rx<WeatherModel?> currentWeatherData = Rx<WeatherModel?>(null);
  Rx<WeatherModel?> foundWeatherData = Rx<WeatherModel?>(null);
  RxBool daySelected = false.obs;
  RxBool errorExist = false.obs;
  RxBool isLoading = false.obs;
  RxBool searchLoading = false.obs;
  var searchLoaded = false.obs;
  final appController = Get.find<LocationController>();
  @override
  void onInit() async {
    super.onInit();
   await getWeatherByLatLon();
  }

  getWeatherByLatLon() async {
    isLoading.value = true;
    try {
      currentWeatherData.value = await getCurrentWeather(
          appController.latitude.value, appController.longitude.value);
      errorExist.value = false;
    } catch (error) {
      errorExist.value = true;
      Get.snackbar(
          'Error',
          error.toString().contains('Failed host') == true
              ? 'Check internet connectivity'
              : error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  searchWeatherByCity(city) async {
    searchLoading.value = true;
    try {
      foundWeatherData.value = null;
      final data = await getWeatherByCity(city);
      foundWeatherData.value = data;
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString().contains('Failed host')
            ? 'Check internet connectivity'
            : error.toString(),
      );
    } finally {
      searchLoading.value = false;
    }
  }
}
