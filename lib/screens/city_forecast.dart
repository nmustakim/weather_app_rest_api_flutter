import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CityForecast extends StatelessWidget {
  const CityForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2b2f55),
      appBar: AppBar(
        title: Text('Weather',

            style: GoogleFonts.inter(fontSize: 34, color: Colors.white),),
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
            const SizedBox(height: 8,),
            Container(
              height: 38,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(

                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 4),
                  prefixIcon: const Icon(Icons.search),
                    hintText: 'Search for a city',
                    filled:true,fillColor:Colors.grey.withOpacity(0.2),border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),)),),
            ),
            const SizedBox(height: 25,),
            Wrap(children: List.generate(5, (index) => buildForecastTile(),))

          ],
        ),
      ),
    );
  }
  Widget buildForecastTile(){
    return             Center(
      child: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              width: 338,
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/Rectangle 5.png'))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('19°',style: GoogleFonts.inter(fontSize: 64,color: Colors.white),),
                  Text(
                    'H:24° L:18°',
                    style: GoogleFonts.inter(fontSize: 15, color: Colors.grey),
                  ),
                  const SizedBox(height: 16,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    Text('Montreal, Canada'   ,style: GoogleFonts.inter(fontSize: 15, color: Colors.white),),Text('Mid Rain',   style: GoogleFonts.inter(fontSize: 15, color: Colors.white),)
                  ],)

                ],)),
          Positioned(right:0,bottom:80,child: Image.asset('assets/images/mid_rain.png',height: 160,width: 160,))
        ],
      ),
    );
  }
}
