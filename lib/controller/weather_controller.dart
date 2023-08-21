import 'package:get/get.dart';
import 'package:weather_app_rest_api_flutter/controller/location_controller.dart';

import '../api_service/weather_service.dart';
import '../model/weather_model.dart';

class WeatherController extends GetxController {
  Rx<WeatherModel?> currentWeatherData = Rx<WeatherModel?>(null);
  RxBool daySelected = false.obs;
  RxBool errorExist = false.obs;
  var isLoaded = false.obs;
  final appController = Get.find<LocationController>();
  @override
  void onInit() async {
    super.onInit();
   getWeather();
  }

  getWeather() async {
    try {
      currentWeatherData.value = await getCurrentWeather(
          appController.latitude.value, appController.longitude.value);
      isLoaded.value = true;
      errorExist.value = false;
    }
    catch(error){
      errorExist.value = true;
      Get.snackbar('Error', error.toString().contains('Failed host')==true? 'Check internet connectivity':error.toString());
    }
    finally{
      update();
    }
  }
}
