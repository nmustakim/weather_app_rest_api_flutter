import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/weather_model.dart';

class ForecastDayDetails extends StatelessWidget {
  final Forecastday dailyData;
  ForecastDayDetails({Key? key, required this.dailyData}) : super(key: key);
  int airQualityIndex = 174;
  @override
  Widget build(BuildContext context) {
    Color progressBarColor;
    String airQualityText;

    if (airQualityIndex <= 50) {
      progressBarColor = Colors.green;
      airQualityText = 'Good';
    } else if (airQualityIndex <= 100) {
      progressBarColor = Colors.yellow;
      airQualityText = 'Moderate';
    } else if (airQualityIndex <= 150) {
      progressBarColor = Colors.orange;
      airQualityText = 'Unhealthy for Sensitive Groups';
    } else if (airQualityIndex <= 200) {
      progressBarColor = Colors.red;
      airQualityText = 'Unhealthy';
    } else {
      progressBarColor = Colors.purple;
      airQualityText = 'Very Unhealthy';
    }
    String uvQualityText;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 95,
          backgroundColor: const Color(0xFF302c54),
          title: Column(
            children: [
              Text(
                dailyData.day?.airQuality?.gbDefraIndex.toString() ?? "",
                style: GoogleFonts.roboto(
                    fontSize: 34,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              Text(
                '${dailyData.day?.avgtempC}°C | ${dailyData.day?.condition!.text}',
                style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFEBEBF5).withOpacity(0.6)),
              ),
              const SizedBox(
                height: 17,
              ),
              ClipOval(
                child: Container(
                  width: 286,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Color(0xF5E0D9FF), // Color with alpha
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    const Color(0xFF2E335A),
                    const Color(0xFF1C1B33).withOpacity(1)
                  ])),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 168,
                    padding: const EdgeInsets.only(left: 32, right: 32, top: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: const Color(0xFF2c245c),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Air Quality',
                          style: GoogleFonts.roboto(
                              color: Colors.grey, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          '3 Low-health risk',
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 30),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        LinearProgressIndicator(
                          value: airQualityIndex / 300.0,
                          backgroundColor: Colors.grey[300],
                          valueColor:
                              AlwaysStoppedAnimation<Color>(progressBarColor),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'See more',
                              style: GoogleFonts.roboto(
                                  color: Colors.grey, fontSize: 18),
                            ),
                            IconButton(
                                icon: const Icon(
                                  Icons.navigate_next,
                                  color: Colors.white,
                                ),
                                onPressed: () => null)
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Expanded(
                    child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 11,
                        ),
                        children: [
                          buildForecastDetailsCard(
                              '☀️ UV INDEX',
                              dailyData.day?.uv.toString(),
                              dailyData.day!.uv! <= 2
                                  ? 'Low'
                                  : dailyData.day!.uv! <= 5
                                      ? 'Moderate'
                                      : dailyData.day!.uv! <= 7
                                          ? 'High'
                                          : dailyData.day!.uv! <= 10
                                              ? 'Very High'
                                              : 'Extreme'),
                          buildForecastDetailsCard(
                              'SUNRISE',
                              dailyData.astro?.sunrise ?? "",
                              'SUNSET: ${dailyData.astro?.sunset ?? ""}'),
                          buildForecastDetailsCard(
                              'WIND SPEED',
                              '${dailyData.day?.maxwindKph} Kph' ?? "",
                              dailyData.day!.maxwindKph! <= 7
                                  ? 'Calm'
                                  : dailyData.day!.maxwindKph! <= 14
                                      ? 'Breezy'
                                      : dailyData.day!.maxwindKph! <= 46
                                          ? 'Windy'
                                          : 'Very Windy'),
                          buildForecastDetailsCard('HUMIDITY',
                              dailyData.day?.avghumidity.toString() ?? '', '')
                        ]),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildForecastDetailsCard(
  String text1,
  text2,
  text3,
) {
  return Container(
    width: 164,
    height: 164,
    decoration: BoxDecoration(
      color: const Color(0xFF2c245c).withOpacity(0.9),
      borderRadius: BorderRadius.circular(22),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1,
            style: GoogleFonts.roboto(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            text2,
            style: GoogleFonts.roboto(
                fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            text3,
            style: GoogleFonts.roboto(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
          )
        ],
      ),
    ),
  );
}
