import 'package:get/get.dart';
import 'package:weather_app_rest_api_flutter/controller/app_controller.dart';

import '../api_service/weather_service.dart';
import '../model/weather_model.dart';

class WeatherController extends GetxController {
Rx<WeatherModel?> currentWeatherData = Rx<WeatherModel?>(null);
  RxBool daySelected = false.obs;
  var isLoaded = false.obs;
  final appController = Get.find<AppController>();
  @override
  void onInit() async {
    super.onInit();
    await getWeather();
  }

  getWeather() async {

    currentWeatherData.value = await getCurrentWeather(
        appController.latitude.value, appController.longitude.value);
    isLoaded.value = true;
    update();
  }
}
