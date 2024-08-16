import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:weather/weather.dart';

import 'hive.dart';

class WeatherService {
  late Home currentHome;
  String key = '7e5168365f08587ccb9cd7428f472c78';
  late String cityName;
  late WeatherFactory wf;
  late Weather w;
  bool isLoaded = false;
  static final WeatherService _instance = WeatherService._();

  WeatherService._();

  static WeatherService get instance {
    return _instance;
  }

  Future<void> initWeather() async {
    int? currentHomeID = HomeHive.instance.getCurrentHome();
    if (currentHomeID != null) {
      currentHome = HomeHive.instance.getHomeFromID(currentHomeID);
      cityName = currentHome.address;
      wf = WeatherFactory(key, language: Language.ITALIAN);
      try{
        w = await wf.currentWeatherByCityName(cityName);
        isLoaded = true;
      } catch(e){
        isLoaded = false;
      }
    }
  }

  bool getStatus(){
    return isLoaded;
  }

  String getTemperature() {
    double temperature = w.temperature!.celsius!;
    return temperature.toStringAsFixed(0);
  }

  String getCity() {
    return w.areaName!;
  }

  String getCountry() {
    return w.country!;
  }

  String getTimeOfDay() {
    DateTime dateTime = w.date!;

    if (dateTime.hour > 6 && dateTime.hour < 18) {
      return 'day';
    } else {
      return 'night';
    }
  }

  String getLottieUri() {
    String uri = 'assets/lottie/${getWeatherDetail()}-${getTimeOfDay()}.json';

    return uri;
  }

  String getWeatherDetail() {
    int weatherConditionCode = w.weatherConditionCode!;

    if (weatherConditionCode == 800) {
      return "clear";
    } else if (weatherConditionCode >= 200 && weatherConditionCode < 300) {
      return "storm";
    } else if (weatherConditionCode >= 300 && weatherConditionCode < 400) {
      return "rain";
    } else if (weatherConditionCode >= 500 && weatherConditionCode < 600) {
      return "rain";
    } else if (weatherConditionCode >= 600 && weatherConditionCode < 700) {
      return "snow";
    } else if (weatherConditionCode >= 700 && weatherConditionCode < 800) {
      return "fog";
    } else if (weatherConditionCode == 801 || weatherConditionCode == 802) {
      return "partial-cloudy";
    } else if (weatherConditionCode == 803 || weatherConditionCode == 804) {
      return "cloudy";
    } else {
      return "Condizioni meteorologiche non disponibili";
    }
  }
}
