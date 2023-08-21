import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/weather_model.dart';

class ForecastHourDetails extends StatelessWidget {
  final Hour hourlyData;

  const ForecastHourDetails({Key? key, required this.hourlyData})
      : super(key: key);

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
        child: hourlyData.airQuality!.usEpaIndex == index + 1
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
                '${hourlyData.tempC}°C | ${hourlyData.condition?.text ?? ''}',
                overflow: TextOverflow.ellipsis,
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
                      Text(
                        '🍃 Air Quality',
                        style: GoogleFonts.roboto(
                            color: Colors.grey, fontSize: 18),
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
                      const SizedBox(
                        height: 12,
                      ),
                      Text(hourlyData.airQuality!.usEpaIndex! <= 1 ? "Good":hourlyData.airQuality!.usEpaIndex! <= 2?"Moderate":hourlyData.airQuality!.usEpaIndex! <= 3? "Unhealthy of Sensitive People":hourlyData.airQuality!.usEpaIndex! <= 4?"Unhealthy":hourlyData.airQuality!.usEpaIndex! <= 5?"Very Unhealthy":"Hazardous",
                        style: GoogleFonts.roboto(
                            color: Colors.white, fontSize: 16),
                      ),

                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'see more',
                            style: GoogleFonts.roboto(
                                color: Colors.grey, fontSize: 18),
                          ),
                          IconButton(
                              icon: const Icon(
                                Icons.navigate_next,
                                color: Colors.white,
                              ),
                              onPressed: () => showAirQualityPopup(context, hourlyData.airQuality!))
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
                        '${hourlyData.chanceOfRain.toString()}%',
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
                          value: hourlyData.chanceOfRain! / 100.0,
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
                        buildForecastDetailsCard(  '☀️ UV INDEX',
                        hourlyData.uv.toString(),
                        hourlyData.uv! <= 2
                            ? 'Low'
                            :  hourlyData.uv! <= 5
                            ? 'Moderate'
                            :  hourlyData.uv! <= 7
                            ? 'High'
                            :  hourlyData.uv! <= 10
                            ? 'Very High'
                            : 'Extreme'),
                      buildForecastDetailsCard(
                          '💨 WIND SPEED',
                          '${hourlyData.windKph!} Kph' ,
                          hourlyData.windKph! <= 7
                              ? 'Calm'
                              : hourlyData.windKph! <= 14
                              ? 'Breezy'
                              : hourlyData.windKph! <= 46
                              ? 'Windy'
                              : 'Very Windy'),
                      buildForecastDetailsCard('💦 HUMIDITY',
                          "${hourlyData.humidity.toString()}%" , hourlyData.humidity! < 25 ? 'Low':hourlyData.humidity! < 30 ? 'Fair':hourlyData.humidity! < 60 ? 'Healthy':hourlyData.humidity! < 70 ? 'Fair' : 'High')

                      ,
                      buildForecastDetailsCard('🌡️ FEELS LIKE', hourlyData.feelslikeC.toString(), hourlyData.feelslikeC! <= 0 ? 'Very Cold': hourlyData.feelslikeC! <= 10 ? 'Cold':hourlyData.feelslikeC! <= 15 ? 'Cool':hourlyData.feelslikeC! <= 20?"Warm":hourlyData.feelslikeC! <= 25?'Warm to hot':hourlyData.feelslikeC! <= 30 ? "Feeling hot":hourlyData.feelslikeC! < 40 ?"Very hot":hourlyData.feelslikeC! <= 50 ? "Extremely hot": "Too hot to live in")
                    ]
                  ),
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

Widget buildForecastDetailsCard(String text1,text2,text3) {
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
         const SizedBox(height: 8,),
         Text( text2,overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
                fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          const SizedBox(height: 8,),
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
void showAirQualityPopup(BuildContext context, AirQuality airQuality) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
      decoration: BoxDecoration(
      gradient: const LinearGradient(
      colors: [Colors.blue, Colors.purple],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(10.0),
      ),

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
       Text('Air Quality',    style: GoogleFonts.roboto(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
      ),
              const SizedBox(height: 20,),
              Text('Carbon mono Oxide:  ${airQuality.co!.toStringAsFixed(2)}',  style: GoogleFonts.roboto(
              fontSize: 18, color: Colors.black),
        ),
              Text('Nitrogen di Oxide:  ${airQuality.no2!.toStringAsFixed(2)}',  style: GoogleFonts.roboto(
                  fontSize: 18, color: Colors.black),),
              Text('Ozone:  ${airQuality.o3!.toStringAsFixed(2)}',  style: GoogleFonts.roboto(
                  fontSize: 18,  color: Colors.black),),
              Text('Sulphur di Oxide:  ${airQuality.so2!.toStringAsFixed(2)}',  style: GoogleFonts.roboto(
                  fontSize: 18,  color: Colors.black),),
              Text('PM2.5:  ${airQuality.pm25!.toStringAsFixed(2)}',  style: GoogleFonts.roboto(
                  fontSize: 18,  color: Colors.black),),
              Text('PM10:  ${airQuality.pm10.toString()}',  style: GoogleFonts.roboto(
                  fontSize: 18, color: Colors.black),),
              Text('US EPA Index:  ${airQuality.usEpaIndex.toString()}',  style: GoogleFonts.roboto(
                  fontSize: 18,  color: Colors.black),),
              Text('UK Defra:  ${airQuality.gbDefraIndex.toString()}',  style: GoogleFonts.roboto(
                  fontSize: 18,  color: Colors.black),),

      Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 30,
        width: double.infinity,
        child: ElevatedButton(
        onPressed: () {
        Navigator.of(context).pop(); // Close the dialog
        },
        child: const Text('Close'),
        ),
      ),
      ),
        ],
      )
      ),
      )
      );
    },
  );
}
