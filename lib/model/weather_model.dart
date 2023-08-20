// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'dart:convert';

WeatherModel weatherModelFromJson(String str) => WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  Location? location;
  Current? current;
  Forecast? forecast;

  WeatherModel({
    this.location,
    this.current,
    this.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    current: json["current"] == null ? null : Current.fromJson(json["current"]),
    forecast: json["forecast"] == null ? null : Forecast.fromJson(json["forecast"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "current": current?.toJson(),
    "forecast": forecast?.toJson(),
  };
}

class Current {
  int? lastUpdatedEpoch;
  String? lastUpdated;
  double? tempC;
  double? tempF;
  int? isDay;
  Condition? condition;
  double? windMph;
  double? windKph;
  int? windDegree;
  WindDir? windDir;
  double? pressureMb;
  double? pressureIn;
  double? precipMm;
  double? precipIn;
  int? humidity;
  int? cloud;
  double? feelslikeC;
  double? feelslikeF;
  double? visKm;
  double? visMiles;
  double? uv;
  double? gustMph;
  double? gustKph;
  AirQuality? airQuality;

  Current({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.visKm,
    this.visMiles,
    this.uv,
    this.gustMph,
    this.gustKph,
    this.airQuality,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    lastUpdatedEpoch: json["last_updated_epoch"],
    lastUpdated: json["last_updated"],
    tempC: json["temp_c"]?.toDouble(),
    tempF: json["temp_f"]?.toDouble(),
    isDay: json["is_day"],
    condition: json["condition"] == null ? null : Condition.fromJson(json["condition"]),
    windMph: json["wind_mph"]?.toDouble(),
    windKph: json["wind_kph"]?.toDouble(),
    windDegree: json["wind_degree"],
    windDir: windDirValues.map[json["wind_dir"]]!,
    pressureMb: json["pressure_mb"],
    pressureIn: json["pressure_in"]?.toDouble(),
    precipMm: json["precip_mm"]?.toDouble(),
    precipIn: json["precip_in"]?.toDouble(),
    humidity: json["humidity"],
    cloud: json["cloud"],
    feelslikeC: json["feelslike_c"]?.toDouble(),
    feelslikeF: json["feelslike_f"]?.toDouble(),
    visKm: json["vis_km"]?.toDouble(),
    visMiles: json["vis_miles"],
    uv: json["uv"],
    gustMph: json["gust_mph"]?.toDouble(),
    gustKph: json["gust_kph"]?.toDouble(),
    airQuality: json["air_quality"] == null ? null : AirQuality.fromJson(json["air_quality"]),
  );

  Map<String, dynamic> toJson() => {
    "last_updated_epoch": lastUpdatedEpoch,
    "last_updated": lastUpdated,
    "temp_c": tempC,
    "temp_f": tempF,
    "is_day": isDay,
    "condition": condition?.toJson(),
    "wind_mph": windMph,
    "wind_kph": windKph,
    "wind_degree": windDegree,
    "wind_dir": windDirValues.reverse[windDir],
    "pressure_mb": pressureMb,
    "pressure_in": pressureIn,
    "precip_mm": precipMm,
    "precip_in": precipIn,
    "humidity": humidity,
    "cloud": cloud,
    "feelslike_c": feelslikeC,
    "feelslike_f": feelslikeF,
    "vis_km": visKm,
    "vis_miles": visMiles,
    "uv": uv,
    "gust_mph": gustMph,
    "gust_kph": gustKph,
    "air_quality": airQuality?.toJson(),
  };
}

class AirQuality {
  double? co;
  double? no2;
  double? o3;
  double? so2;
  double? pm25;
  double? pm10;
  int? usEpaIndex;
  int? gbDefraIndex;
  String? aqiData;

  AirQuality({
    this.co,
    this.no2,
    this.o3,
    this.so2,
    this.pm25,
    this.pm10,
    this.usEpaIndex,
    this.gbDefraIndex,
    this.aqiData,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) => AirQuality(
    co: json["co"]?.toDouble(),
    no2: json["no2"]?.toDouble(),
    o3: json["o3"]?.toDouble(),
    so2: json["so2"]?.toDouble(),
    pm25: json["pm2_5"]?.toDouble(),
    pm10: json["pm10"]?.toDouble(),
    usEpaIndex: json["us-epa-index"],
    gbDefraIndex: json["gb-defra-index"],
    aqiData: json["aqi_data"],
  );

  Map<String, dynamic> toJson() => {
    "co": co,
    "no2": no2,
    "o3": o3,
    "so2": so2,
    "pm2_5": pm25,
    "pm10": pm10,
    "us-epa-index": usEpaIndex,
    "gb-defra-index": gbDefraIndex,
    "aqi_data": aqiData,
  };
}

class Condition {
  String? text;
  String? icon;
  int? code;

  Condition({
    this.text,
    this.icon,
    this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
    text: json["text"],
    icon: json["icon"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "icon": icon,
    "code": code,
  };
}

enum WindDir {
  E,
  ESE,
  S,
  SE,
  SSE,
  SSW
}

final windDirValues = EnumValues({
  "E": WindDir.E,
  "ESE": WindDir.ESE,
  "S": WindDir.S,
  "SE": WindDir.SE,
  "SSE": WindDir.SSE,
  "SSW": WindDir.SSW
});

class Forecast {
  List<Forecastday>? forecastday;

  Forecast({
    this.forecastday,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    forecastday: json["forecastday"] == null ? [] : List<Forecastday>.from(json["forecastday"]!.map((x) => Forecastday.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "forecastday": forecastday == null ? [] : List<dynamic>.from(forecastday!.map((x) => x.toJson())),
  };
}

class Forecastday {
  DateTime? date;
  int? dateEpoch;
  Day? day;
  Astro? astro;
  List<Hour>? hour;

  Forecastday({
    this.date,
    this.dateEpoch,
    this.day,
    this.astro,
    this.hour,
  });

  factory Forecastday.fromJson(Map<String, dynamic> json) => Forecastday(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    dateEpoch: json["date_epoch"],
    day: json["day"] == null ? null : Day.fromJson(json["day"]),
    astro: json["astro"] == null ? null : Astro.fromJson(json["astro"]),
    hour: json["hour"] == null ? [] : List<Hour>.from(json["hour"]!.map((x) => Hour.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "date_epoch": dateEpoch,
    "day": day?.toJson(),
    "astro": astro?.toJson(),
    "hour": hour == null ? [] : List<dynamic>.from(hour!.map((x) => x.toJson())),
  };
}

class Astro {
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  String? moonPhase;
  String? moonIllumination;
  int? isMoonUp;
  int? isSunUp;

  Astro({
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.moonIllumination,
    this.isMoonUp,
    this.isSunUp,
  });

  factory Astro.fromJson(Map<String, dynamic> json) => Astro(
    sunrise: json["sunrise"],
    sunset: json["sunset"],
    moonrise: json["moonrise"],
    moonset: json["moonset"],
    moonPhase: json["moon_phase"],
    moonIllumination: json["moon_illumination"],
    isMoonUp: json["is_moon_up"],
    isSunUp: json["is_sun_up"],
  );

  Map<String, dynamic> toJson() => {
    "sunrise": sunrise,
    "sunset": sunset,
    "moonrise": moonrise,
    "moonset": moonset,
    "moon_phase": moonPhase,
    "moon_illumination": moonIllumination,
    "is_moon_up": isMoonUp,
    "is_sun_up": isSunUp,
  };
}

class Day {
  double? maxtempC;
  double? maxtempF;
  double? mintempC;
  double? mintempF;
  double? avgtempC;
  double? avgtempF;
  double? maxwindMph;
  double? maxwindKph;
  double? totalprecipMm;
  double? totalprecipIn;
  double? totalsnowCm;
  double? avgvisKm;
  double? avgvisMiles;
  double? avghumidity;
  int? dailyWillItRain;
  int? dailyChanceOfRain;
  int? dailyWillItSnow;
  int? dailyChanceOfSnow;
  Condition? condition;
  double? uv;
  AirQuality? airQuality;

  Day({
    this.maxtempC,
    this.maxtempF,
    this.mintempC,
    this.mintempF,
    this.avgtempC,
    this.avgtempF,
    this.maxwindMph,
    this.maxwindKph,
    this.totalprecipMm,
    this.totalprecipIn,
    this.totalsnowCm,
    this.avgvisKm,
    this.avgvisMiles,
    this.avghumidity,
    this.dailyWillItRain,
    this.dailyChanceOfRain,
    this.dailyWillItSnow,
    this.dailyChanceOfSnow,
    this.condition,
    this.uv,
    this.airQuality,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    maxtempC: json["maxtemp_c"]?.toDouble(),
    maxtempF: json["maxtemp_f"]?.toDouble(),
    mintempC: json["mintemp_c"]?.toDouble(),
    mintempF: json["mintemp_f"]?.toDouble(),
    avgtempC: json["avgtemp_c"]?.toDouble(),
    avgtempF: json["avgtemp_f"]?.toDouble(),
    maxwindMph: json["maxwind_mph"]?.toDouble(),
    maxwindKph: json["maxwind_kph"]?.toDouble(),
    totalprecipMm: json["totalprecip_mm"]?.toDouble(),
    totalprecipIn: json["totalprecip_in"]?.toDouble(),
    totalsnowCm: json["totalsnow_cm"]?.toDouble(),
    avgvisKm: json["avgvis_km"]?.toDouble(),
    avgvisMiles: json["avgvis_miles"],
    avghumidity: json["avghumidity"],
    dailyWillItRain: json["daily_will_it_rain"],
    dailyChanceOfRain: json["daily_chance_of_rain"],
    dailyWillItSnow: json["daily_will_it_snow"],
    dailyChanceOfSnow: json["daily_chance_of_snow"],
    condition: json["condition"] == null ? null : Condition.fromJson(json["condition"]),
    uv: json["uv"],
    airQuality: json["air_quality"] == null ? null : AirQuality.fromJson(json["air_quality"]),
  );

  Map<String, dynamic> toJson() => {
    "maxtemp_c": maxtempC,
    "maxtemp_f": maxtempF,
    "mintemp_c": mintempC,
    "mintemp_f": mintempF,
    "avgtemp_c": avgtempC,
    "avgtemp_f": avgtempF,
    "maxwind_mph": maxwindMph,
    "maxwind_kph": maxwindKph,
    "totalprecip_mm": totalprecipMm,
    "totalprecip_in": totalprecipIn,
    "totalsnow_cm": totalsnowCm,
    "avgvis_km": avgvisKm,
    "avgvis_miles": avgvisMiles,
    "avghumidity": avghumidity,
    "daily_will_it_rain": dailyWillItRain,
    "daily_chance_of_rain": dailyChanceOfRain,
    "daily_will_it_snow": dailyWillItSnow,
    "daily_chance_of_snow": dailyChanceOfSnow,
    "condition": condition?.toJson(),
    "uv": uv,
    "air_quality": airQuality?.toJson(),
  };
}

class Hour {
  int? timeEpoch;
  String? time;
  double? tempC;
  double? tempF;
  int? isDay;
  Condition? condition;
  double? windMph;
  double? windKph;
  int? windDegree;
  WindDir? windDir;
  double? pressureMb;
  double? pressureIn;
  double? precipMm;
  double? precipIn;
  int? humidity;
  int? cloud;
  double? feelslikeC;
  double? feelslikeF;
  double? windchillC;
  double? windchillF;
  double? heatindexC;
  double? heatindexF;
  double? dewpointC;
  double? dewpointF;
  int? willItRain;
  int? chanceOfRain;
  int? willItSnow;
  int? chanceOfSnow;
  double? visKm;
  double? visMiles;
  double? gustMph;
  double? gustKph;
  double? uv;
  AirQuality? airQuality;

  Hour({
    this.timeEpoch,
    this.time,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.windchillC,
    this.windchillF,
    this.heatindexC,
    this.heatindexF,
    this.dewpointC,
    this.dewpointF,
    this.willItRain,
    this.chanceOfRain,
    this.willItSnow,
    this.chanceOfSnow,
    this.visKm,
    this.visMiles,
    this.gustMph,
    this.gustKph,
    this.uv,
    this.airQuality,
  });

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
    timeEpoch: json["time_epoch"],
    time: json["time"],
    tempC: json["temp_c"]?.toDouble(),
    tempF: json["temp_f"]?.toDouble(),
    isDay: json["is_day"],
    condition: json["condition"] == null ? null : Condition.fromJson(json["condition"]),
    windMph: json["wind_mph"]?.toDouble(),
    windKph: json["wind_kph"]?.toDouble(),
    windDegree: json["wind_degree"],
    windDir: windDirValues.map[json["wind_dir"]]!,
    pressureMb: json["pressure_mb"]?.toDouble(),
    pressureIn: json["pressure_in"]?.toDouble(),
    precipMm: json["precip_mm"]?.toDouble(),
    precipIn: json["precip_in"]?.toDouble(),
    humidity: json["humidity"],
    cloud: json["cloud"],
    feelslikeC: json["feelslike_c"]?.toDouble(),
    feelslikeF: json["feelslike_f"]?.toDouble(),
    windchillC: json["windchill_c"]?.toDouble(),
    windchillF: json["windchill_f"]?.toDouble(),
    heatindexC: json["heatindex_c"]?.toDouble(),
    heatindexF: json["heatindex_f"]?.toDouble(),
    dewpointC: json["dewpoint_c"]?.toDouble(),
    dewpointF: json["dewpoint_f"]?.toDouble(),
    willItRain: json["will_it_rain"],
    chanceOfRain: json["chance_of_rain"],
    willItSnow: json["will_it_snow"],
    chanceOfSnow: json["chance_of_snow"],
    visKm: json["vis_km"]?.toDouble(),
    visMiles: json["vis_miles"],
    gustMph: json["gust_mph"]?.toDouble(),
    gustKph: json["gust_kph"]?.toDouble(),
    uv: json["uv"],
    airQuality: json["air_quality"] == null ? null : AirQuality.fromJson(json["air_quality"]),
  );

  Map<String, dynamic> toJson() => {
    "time_epoch": timeEpoch,
    "time": time,
    "temp_c": tempC,
    "temp_f": tempF,
    "is_day": isDay,
    "condition": condition?.toJson(),
    "wind_mph": windMph,
    "wind_kph": windKph,
    "wind_degree": windDegree,
    "wind_dir": windDirValues.reverse[windDir],
    "pressure_mb": pressureMb,
    "pressure_in": pressureIn,
    "precip_mm": precipMm,
    "precip_in": precipIn,
    "humidity": humidity,
    "cloud": cloud,
    "feelslike_c": feelslikeC,
    "feelslike_f": feelslikeF,
    "windchill_c": windchillC,
    "windchill_f": windchillF,
    "heatindex_c": heatindexC,
    "heatindex_f": heatindexF,
    "dewpoint_c": dewpointC,
    "dewpoint_f": dewpointF,
    "will_it_rain": willItRain,
    "chance_of_rain": chanceOfRain,
    "will_it_snow": willItSnow,
    "chance_of_snow": chanceOfSnow,
    "vis_km": visKm,
    "vis_miles": visMiles,
    "gust_mph": gustMph,
    "gust_kph": gustKph,
    "uv": uv,
    "air_quality": airQuality?.toJson(),
  };
}

class Location {
  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  String? tzId;
  int? localtimeEpoch;
  String? localtime;

  Location({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json["name"],
    region: json["region"],
    country: json["country"],
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
    tzId: json["tz_id"],
    localtimeEpoch: json["localtime_epoch"],
    localtime: json["localtime"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "region": region,
    "country": country,
    "lat": lat,
    "lon": lon,
    "tz_id": tzId,
    "localtime_epoch": localtimeEpoch,
    "localtime": localtime,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
