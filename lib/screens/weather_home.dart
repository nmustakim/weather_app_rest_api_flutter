import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../controller/app_controller.dart';
import '../model/weather_model.dart';
import 'city_forecast.dart';
import 'forecast_details.dart';

class WeatherHome extends StatelessWidget {
  const WeatherHome({super.key});

  @override
  Widget build(BuildContext context) {
    final appController = Get.put(AppController());
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if (appController.isLoaded.value == true) {
            return
              FutureBuilder(
                future: appController.currentWeatherData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    WeatherModel weatherData = snapshot.data;
                    return Stack(
                      children: [
                        Image.asset(
                          'assets/images/background.png',
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              weatherData.location!.name!,
                              style: GoogleFonts.roboto(
                                  fontSize: 34, color: Colors.white),
                            ),
                            Text(
                              '${weatherData.current!.tempC}°C',
                              style: GoogleFonts.roboto(
                                  fontSize: 86,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200),
                            ),
                            Text(
                              weatherData.current!.condition!.text!,
                              style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFEBEBF5).withOpacity(
                                      0.6)),
                            ),
                            Text(
                              '${weatherData.forecast!.forecastday!.first.day!
                                  .maxtempC}°C ${weatherData.forecast!
                                  .forecastday!.first.day!.mintempC}°C',
                              style: GoogleFonts.roboto(
                                  fontSize: 20, color: Colors.white),
                            ),
                            Center(
                              child: Image.asset(
                                'assets/images/house.png',
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(44),
                                topRight: Radius.circular(44),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xFF2E335A).withOpacity(0.8),
                                  const Color(0xFF1C1B33)
                                ],
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        'Hourly Forecast',
                                        style: GoogleFonts.roboto(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                      Text(
                                        'Weekly Forecast',
                                        style: GoogleFonts.roboto(
                                            fontSize: 15, color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 13.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Wrap(
                                      spacing: 10,
                                      children: List.generate(
                                          weatherData.forecast!
                                              .forecastday!
                                              .first.hour!.length ,
                                              (index) =>
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                ForecastDetails()));
                                                  },
                                                  child: buildForecastContainer(
                                                      weatherData.forecast!
                                                          .forecastday!
                                                          .first.hour![index],
                                                      context))),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 12),
                                      child: Image.asset(
                                        'assets/images/map_icon.png',
                                      ),
                                    ),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.only(
                                                top: 12),
                                            child: Image.asset(
                                              'assets/images/rect4.png',
                                              height: 86,
                                              width: 250,
                                            )),
                                        Container(
                                          height: 64,
                                          width: 64,
                                          margin: const EdgeInsets.only(
                                              top: 16, left: 20),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                64),
                                          ),
                                          child: const Icon(
                                            Icons.add_rounded,
                                            size: 44,
                                            color: Color(0xFF48319D),
                                          ),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () =>
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CityForecast())),
                                      child: Image.asset(
                                        'assets/images/list.png',
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text('No Data'),
                        )
                      ],
                    );
                  }
                },
              );
          }
          else {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            );
          }
        }
        ),
      ),
    );
  }

  Widget buildForecastContainer(Hour hour, context) {
    DateTime dateTime = DateTime.parse(hour.time!);
    String time = DateFormat('HH:mm').format(dateTime);
    return Container(
      height: 146,
      width: 60,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: GoogleFonts.roboto(color: Colors.white),
          ),
          const SizedBox(height: 16),
          Image.network(hour.condition!.icon!),
          const SizedBox(height: 16),
          Text(
            '${hour.tempC}°C',
            style: GoogleFonts.roboto(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
