import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../controller/weather_controller.dart';
import '../model/weather_model.dart';
import 'search_by_city.dart';
import 'forecast_day_details.dart';
import 'forecast_hour_details.dart';

class WeatherHome extends StatelessWidget {
  const WeatherHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = Get.put(WeatherController());
    void reload() async {
      await weatherController.getWeatherByLatLon();
    }

    return SafeArea(child: Scaffold(body: Obx(() {
      if (weatherController.errorExist.value) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.deepPurple],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: InkWell(
                      onTap: () => reload(),
                      child: const Icon(
                        Icons.refresh,
                        size: 50,
                        color: Colors.white,

                      )))
            ],
          ),
        );
      } else if (!weatherController.isLoaded.value) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.deepPurple],
            ),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Center(child: CircularProgressIndicator(color: Colors.white,))],
          ),
        );
      } else if (weatherController.currentWeatherData.value != null) {
        WeatherModel weatherData = weatherController.currentWeatherData.value!;
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
                  weatherData.location?.name ?? '',
                  style: GoogleFonts.roboto(fontSize: 34, color: Colors.white),
                ),
                Text(
                  '${weatherData.current?.tempC ?? ""}°C',
                  style: GoogleFonts.roboto(
                      fontSize: 86,
                      color: Colors.white,
                      fontWeight: FontWeight.w200),
                ),
                Text(
                  weatherData.current?.condition?.text ?? "",
                  style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFEBEBF5).withOpacity(0.6)),
                ),
                Text(
                  '${weatherData.forecast?.forecastday?.first.day?.maxtempC ?? ""}°C ${weatherData.forecast?.forecastday?.first.day?.mintempC ?? ""}°C',
                  style: GoogleFonts.roboto(fontSize: 20, color: Colors.white),
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
                height: 280,
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
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              weatherController.daySelected.value = false;
                            },
                            child: Text(
                              'Hourly Forecast',
                              style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  color: weatherController.daySelected.value !=
                                          true
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              weatherController.daySelected.value = true;
                            },
                            child: Text(
                              'Weekly Forecast',
                              style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  color: weatherController.daySelected.value ==
                                          true
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    weatherController.daySelected.value != true
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 13.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Wrap(
                                spacing: 10,
                                children: List.generate(
                                    weatherData.forecast!.forecastday!.first
                                        .hour!.length,
                                    (index) => InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForecastHourDetails(
                                                          hourlyData: weatherData
                                                              .forecast!
                                                              .forecastday!
                                                              .first
                                                              .hour![index])));
                                        },
                                        child: buildHourlyForecastContainer(
                                            weatherData.forecast!.forecastday!
                                                .first.hour![index],
                                            context))),
                              ),
                            ),
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 13.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Wrap(
                                spacing: 10,
                                children: List.generate(
                                    weatherData.forecast!.forecastday!.length,
                                    (index) => InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForecastDayDetails(
                                                        dailyData: weatherData
                                                                .forecast!
                                                                .forecastday![
                                                            index],
                                                      )));
                                        },
                                        child: buildDailyForecastContainer(
                                            weatherData
                                                .forecast!.forecastday![index],
                                            context))),
                              ),
                            ),
                          ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 12),
                            child: Image.asset(
                              'assets/images/rect4.png',
                              height: 75,
                              width: 250,
                            )),
                        Container(
                          height: 55,
                          width: 55,
                          margin: const EdgeInsets.only(top: 16, left: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(64),
                          ),
                          child:     InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchByCity())),
                            child: const Icon(
                              Icons.search,
                              size: 30,
                              color: Colors.black,
                            ),
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
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.deepPurple],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: IconButton(
                      onPressed: () => reload(),
                      icon: const Icon(
                        Icons.refresh,
                        size: 50,
                        color: Colors.white,
                      )))
            ],
          ),
        );
      }
    })));
  }
}

Widget buildHourlyForecastContainer(Hour hour, context) {
  DateTime dateTime = DateTime.parse(hour.time!);
  String time = DateFormat('HH:mm').format(dateTime);
  return Container(
    height: 135,
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
        Image.network('https:${hour.condition?.icon ?? ''}'),
        Text(
          '${hour.tempC}°C',
          style: GoogleFonts.roboto(color: Colors.white),
        ),
      ],
    ),
  );
}

Widget buildDailyForecastContainer(Forecastday forecastDay, context) {
  String day =
      DateFormat.MMMd().format(DateTime.parse(forecastDay.date.toString()));
  return Container(
    height: 135,
    width: 60,
    decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(30)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          day,
          style: GoogleFonts.roboto(color: Colors.white),
        ),
        Image.network('https:${forecastDay.day?.condition?.icon ?? ''}'),
        const SizedBox(
          height: 6,
        ),
        Text(
          "${forecastDay.day?.avgtempC}°C",
          style: GoogleFonts.roboto(color: Colors.white),
        ),
      ],
    ),
  );
}
