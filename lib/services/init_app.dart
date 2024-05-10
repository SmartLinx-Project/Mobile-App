import 'package:smartlinx/services/getinfo.dart';
import 'package:smartlinx/services/hiveMethod/device_plug_hive.dart';
import 'package:smartlinx/services/userdata.dart';
import 'package:smartlinx/services/weather.dart';
import 'auth.dart';
import 'hiveMethod/device_light_hive.dart';
import 'hiveMethod/device_thermostat_hive.dart';
import 'hiveMethod/favourite_hive.dart';
import 'hiveMethod/home_hive.dart';
import 'hiveMethod/room_hive.dart';
import 'hiveMethod/userdata_hive.dart';

class InitApp {
  Future<void> startInit() async {
    if (await Auth().isUserLoggedIn()) {
      while(!await GetInfo().manageJson()){}
      await UserData.instance.init();
      await FamilyMembersHive.instance.init();
      await HomeHive.instance.init();
      await RoomHive.instance.init();
      await DeviceLightHive.instance.init();
      await DevicePlugHive.instance.init();
      await DeviceThermostatHive.instance.init();
      await FavouriteHive.instance.init();
      if(HomeHive.instance.getAllHomes().isNotEmpty){
        await WeatherService.instance.initWeather();
      }
    }
  }
}
