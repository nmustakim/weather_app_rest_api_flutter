import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_rest_api_flutter/controller/weather_controller.dart';
import 'package:weather_app_rest_api_flutter/model/weather_model.dart';

class SearchByCity extends StatefulWidget {
  const SearchByCity({super.key});

  @override
  State<SearchByCity> createState() => _SearchByCityState();
}

class _SearchByCityState extends State<SearchByCity> {
  final searchController = TextEditingController();
  final weatherController = Get.find<WeatherController>();
  @override
  void dispose() {
    super.dispose();
    weatherController.foundWeatherData.value = null;
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.find<WeatherController>();
    return Scaffold(
      backgroundColor: const Color(0xFF2b2f55),
      appBar: AppBar(
        title: Text(
          'Weather',
          style: GoogleFonts.inter(fontSize: 34, color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFF2b2f55),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.navigate_before,
              size: 40,
            )),
        actions: [Image.asset('assets/images/3dots.png')],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 38,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 16, top: 4),
                    suffixIcon: InkWell(
                        onTap: ()  {
                          if (searchController.text.isEmpty) {
                            Get.snackbar('Err', 'Please type City');
                          } else {
                             weatherController
                                .searchWeatherByCity(searchController.text);
                          }
                        },
                        child: const Icon(Icons.search)),
                    hintText: 'Search for a city',
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Obx(() {
              if(weatherController.searchLoading.value  == true){
                return const Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Center(child: CircularProgressIndicator(color: Colors.white,),)
                ],);
              }
              else if (
                  weatherController.foundWeatherData.value != null) {
                return buildForecastTile(weatherController.foundWeatherData.value!);
              }
              else{
                return const Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Center(child: Text('No Data'),)
                ],);

              }
            }
              )
          ],
        ),
      ),
    );
  }

  Widget buildForecastTile(WeatherModel weatherData) {
    return Center(
      child: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              width: 338,
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Rectangle 5.png'))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${weatherData.current!.tempC?.toStringAsFixed(1)}°C',
                    style: GoogleFonts.inter(fontSize: 44, color: Colors.white),
                  ),
                  Text(
                    '${weatherData.forecast?.forecastday?.first.day?.maxtempC ?? ""}°C ${weatherData.forecast?.forecastday?.first.day?.mintempC ?? ""}°C',
                    style: GoogleFonts.inter(fontSize: 15, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${weatherData.location!.name!}, ${weatherData.location!.country}',
                          style: GoogleFonts.inter(
                              fontSize: 15, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        weatherData.current!.condition!.text!,
                        style: GoogleFonts.inter(
                            fontSize: 15, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  )
                ],
              )),
          Positioned(
            right: 0,

            bottom: 80,
            child: Image.network(
                'https:${weatherData.current!.condition?.icon ?? ''}'),
          )
        ],
      ),
    );
  }
}
