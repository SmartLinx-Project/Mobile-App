import 'dart:convert';

import 'package:flutter_wear_os_connectivity/flutter_wear_os_connectivity.dart';
import 'package:smartlinx/services/hive.dart';
import 'package:smartlinx/services/hiveMethod/device_light_hive.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/hiveMethod/room_hive.dart';
import 'package:smartlinx/services/http.dart';
import 'package:smartlinx/services/wearable/sender.dart';
import '../auth.dart';
import '../hiveMethod/device_plug_hive.dart';

class WearableReceiver {
  void startListen() async {
    FlutterWearOsConnectivity flutterWearOsConnectivity =
        FlutterWearOsConnectivity();
    flutterWearOsConnectivity.configureWearableAPI();
    flutterWearOsConnectivity.messageReceived().listen((message) async{
      if(await Auth().isUserLoggedIn()){
      handleMessage(message, flutterWearOsConnectivity);
      }
    });
  }

  void handleMessage(WearOSMessage startMessage, FlutterWearOsConnectivity flutterWearOsConnectivity) {
    WearOSMessage message = startMessage;
    String convertedMessage = const Utf8Decoder().convert(message.data);
    parseMessage(convertedMessage, flutterWearOsConnectivity);
  }

  void parseMessage(String json, FlutterWearOsConnectivity flutterWearOsConnectivity) {
    Map<String, dynamic> jsonData = jsonDecode(json);
    if (jsonData['command'] == 'setState') {
      int deviceID = int.parse(jsonData['deviceID'] as String);
      String state = jsonData['value'] as String;
      String type = jsonData['type'] as String;
      setStatus(deviceID, state, type, flutterWearOsConnectivity);
    } else if(jsonData['command'] == 'getState'){
      WearableSender().initSend(flutterWearOsConnectivity);
    }
  }

  void setStatus(int deviceID, String state, String type, FlutterWearOsConnectivity flutterWearOsConnectivity) async {
    int hubID = 0;
    String ieeeAddress = '';
    String command = '{"state": "$state"}';
    if (type == 'light') {
      DeviceLight deviceLight =
          DeviceLightHive.instance.getDevicesFromID(deviceID);
      Room room = RoomHive.instance.getRoomFromID(deviceLight.roomID);
      ieeeAddress = deviceLight.ieeeAddress;
      hubID = HomeHive.instance.getHomeFromID(room.homeID).hubID;
    } else if (type == 'plug') {
      DevicePlug devicePlug = DevicePlugHive.instance.getDevicesFromID(deviceID);
      Room room = RoomHive.instance.getRoomFromID(devicePlug.roomID);
      ieeeAddress = devicePlug.ieeeAddress;
      hubID = HomeHive.instance.getHomeFromID(room.homeID).hubID;
    }
    if (await HttpService()
        .setStatus(hubID: hubID, ieeeAddress: ieeeAddress, command: command)) {
      if (type == 'light') {
        DeviceLight deviceLight =
            DeviceLightHive.instance.getDevicesFromID(deviceID);
        deviceLight.enabled = (state == 'on') ? true : false;
        DeviceLightHive.instance.editDevice(deviceLight);
      } else if (type == 'plug') {
        DevicePlug devicePlug =
            DevicePlugHive.instance.getDevicesFromID(deviceID);
        devicePlug.enabled = (state == 'on') ? true : false;
        DevicePlugHive.instance.editDevice(devicePlug);
      }
    }
    WearableSender().initSend(flutterWearOsConnectivity);
  }
}
