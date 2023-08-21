import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/weather_model.dart';
import 'forecast_hour_details.dart';

class ForecastDayDetails extends StatelessWidget {
  final Forecastday dailyData;
  const ForecastDayDetails({Key? key, required this.dailyData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double portionWidth = 254 / 6;

    List<Widget> coloredPortions = List.generate(
      6,
          (index) => Container(
        width: portionWidth,
        height: 20,
        color: index == 0
            ? Colors.green
            : index == 1
            ? Colors.yellow
            : index == 2
            ? Colors.orange
            : index == 3
            ? Colors.red
            : index == 4
            ? Colors.purple
            : Colors.brown,
        child: dailyData.day?.airQuality!.usEpaIndex == index + 1
            ? Container(
          alignment: Alignment.center,
          child: const Icon(
            Icons.circle,
            size: 10,
          ),
        )
            : Container(),
      ),
    );



    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 65,
          backgroundColor: const Color(0xFF302c54),
          title: Column(
            children: [
              const SizedBox(height: 20,),
              Text(
                '${dailyData.day?.avgtempC}°C | ${dailyData.day?.condition!.text}',
                style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFEBEBF5).withOpacity(0.6)),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 17,
              ),
              ClipOval(
                child: Container(
                  width: 286,
                  height: 15,
                  decoration: const BoxDecoration(
                    color: Color(0xF5E0D9FF), // Color with alpha
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(

              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF2E335A),
                        const Color(0xFF1C1B33).withOpacity(1)
                      ])),
            
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [

                Container(
                  height: 130,
                  padding: const EdgeInsets.only(left: 32, right: 32, top: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: const Color(0xFF2c245c),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '🍃 Air Quality',
                            style: GoogleFonts.roboto(
                                color: Colors.grey, fontSize: 18),
                          ),

                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),

                      SizedBox(
                        height: 10,
                        child: Row(
                          children: coloredPortions,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(dailyData.day!.airQuality!.usEpaIndex! <= 1 ? "Good":dailyData.day!.airQuality!.usEpaIndex! <= 2?"Moderate":dailyData.day!.airQuality!.usEpaIndex! <= 3? "Unhealthy of Sensitive People":dailyData.day!.airQuality!.usEpaIndex! <= 4?"Unhealthy":dailyData.day!.airQuality!.usEpaIndex! <= 5?"Very Unhealthy":"Hazardous",style: GoogleFonts.roboto(
                      color: Colors.white, fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'See more',
                            style: GoogleFonts.roboto(
                                color: Colors.grey, fontSize: 16),
                          ),
                          IconButton(
                              icon: const Icon(
                                Icons.navigate_next,
                                color: Colors.white,
                              ),
                              onPressed: () => showAirQualityPopup(context, dailyData.day!.airQuality!))
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 12,),
                Container(
                  height: 130,
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
                        '🌧️ Chance of Rain',
                        style: GoogleFonts.roboto(
                            color: Colors.grey, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                      '${dailyData.day!.dailyChanceOfRain.toString()}%',
                        style: GoogleFonts.roboto(
                            color: Colors.white, fontSize: 30),
                      ),
                      const SizedBox(
                        height: 12,
                      ),     Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), // Rounded border
                          border: Border.all(color: Colors.grey),
                        ),
                        child: LinearProgressIndicator(
                          value: dailyData.day!.dailyChanceOfRain! / 100.0,
                          backgroundColor: Colors.grey,
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                        ),
                      ),
                      const SizedBox(height: 16),

                    ],
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                SizedBox(
                  height: 350,
                  child: GridView(
                    physics: const NeverScrollableScrollPhysics(),
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
                            '🔅 SUNRISE',
                            dailyData.astro?.sunrise ?? "",
                            'SUNSET: ${dailyData.astro?.sunset ?? ""}'),
                        buildForecastDetailsCard(
                            '💨 WIND SPEED',
                            '${dailyData.day?.maxwindKph} Kph',
                            dailyData.day!.maxwindKph! <= 7
                                ? 'Calm'
                                : dailyData.day!.maxwindKph! <= 14
                                    ? 'Breezy'
                                    : dailyData.day!.maxwindKph! <= 46
                                        ? 'Windy'
                                        : 'Very Windy'),
                        buildForecastDetailsCard('💦 HUMIDITY',
                            "${dailyData.day?.avghumidity.toString()}%" , dailyData.day!.avghumidity! < 25 ? 'Low':dailyData.day!.avghumidity! < 30 ? 'Fair':dailyData.day!.avghumidity! < 60 ? 'Healthy': dailyData.day!.avghumidity! < 70 ? 'Fair' : 'High')
                      ]),
                ),
                const SizedBox(
                  height: 13,
                ),
              ],
            ),
          ),
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
          const SizedBox(
            height: 8,
          ),
          Text(
            text2,
            style: GoogleFonts.roboto(
                fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          const SizedBox(
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

