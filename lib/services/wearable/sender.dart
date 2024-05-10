import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_wear_os_connectivity/flutter_wear_os_connectivity.dart';
import 'package:smartlinx/services/hive.dart';
import 'package:smartlinx/services/hiveMethod/device_light_hive.dart';
import 'package:smartlinx/services/hiveMethod/favourite_hive.dart';
import 'package:smartlinx/services/wearable/object/light.dart';
import 'package:smartlinx/services/wearable/object/thermometer.dart';
import '../hiveMethod/device_plug_hive.dart';
import '../hiveMethod/device_thermostat_hive.dart';
import 'object/plug.dart';

class WearableSender{
  void initSend(FlutterWearOsConnectivity flutterWearOsConnectivity) async {
    List<WearOsDevice> connectedDevices = await flutterWearOsConnectivity.getConnectedDevices();
    for (int i = 0; i < connectedDevices.length; i++) {
    }
    if (connectedDevices.isNotEmpty) {
      String message = extractDevice();
      sendMessage(flutterWearOsConnectivity, connectedDevices[0], message);
    } else {
    }
  }

  void sendMessage(FlutterWearOsConnectivity flutterWearOsConnectivity, WearOsDevice pairedDevice, String message) async {
    String path = '/home';
    Uint8List messageBytes = Uint8List.fromList(utf8.encode(message));

    await flutterWearOsConnectivity.sendMessage(
      messageBytes,
      deviceId: pairedDevice.id,
      path: path,
    ).then((requestId) {
    }).catchError((error) {
    });
  }

  String objectToJson(List<Light> listLight, List<Plug> listPlug, List<Thermometer> listThermometer){

    Map<String, dynamic> jsonData = {
      'lights': listLight.map((light) => light.toJson()).toList(),
      'plugs': listPlug.map((plug) => plug.toJson()).toList(),
      'thermometers': listThermometer.map((thermometer) => thermometer.toJson()).toList(),
    };
    
    String jsonString = jsonEncode(jsonData);
    return jsonString;
  }

  String extractDevice(){
    List<DeviceLight> allLights = DeviceLightHive.instance.getAllDevices();
    List<DevicePlug> allPlugs = DevicePlugHive.instance.getAllDevices();
    List<DeviceThermostat> allThermometers = DeviceThermostatHive.instance.getAllDevices();
    List<Favourite> favourites = FavouriteHive.instance.getAllFavourite();
    List<Light> filteredLight = [];
    List<Plug> filteredPlug = [];
    List<Thermometer> filteredThermometer = [];

    for(int i = 0; i < allLights.length; i++){
      for(int a = 0; a < favourites.length; a++){
        if(allLights[i].deviceID == favourites[a].deviceID){
          filteredLight.add(Light(allLights[i].deviceID, allLights[i].name, allLights[i].enabled, allLights[i].isOnline));
        }
      }
    }
    for(int i = 0; i < allPlugs.length; i++){
      for(int a = 0; a < favourites.length; a++){
        if(allPlugs[i].deviceID == favourites[a].deviceID){
          filteredPlug.add(Plug(allPlugs[i].deviceID, allPlugs[i].name, allPlugs[i].enabled, allPlugs[i].isOnline));
        }
      }
    }

    for(int i = 0; i < allThermometers.length; i++){
      for(int a = 0; a < favourites.length; a++){
        if(allThermometers[i].deviceID == favourites[a].deviceID){
          filteredThermometer.add(Thermometer(allThermometers[i].deviceID, allThermometers[i].name, allThermometers[i].temperature, allThermometers[i].humidity, allThermometers[i].isOnline));
        }
      }
    }
    String message = objectToJson(filteredLight, filteredPlug, filteredThermometer);
    return message;
  }
}