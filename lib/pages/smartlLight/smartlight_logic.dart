import 'package:smartlinx/services/hive.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/http.dart';

import '../../services/hiveMethod/room_hive.dart';

class SmartLightLogic {
  Future<bool> turnOnLightDevice(DeviceLight device) async {
    String command = '{"state": "on"}';
    int hubID = HomeHive.instance.getHomeFromID(RoomHive.instance.getRoomFromID(device.roomID).homeID).hubID;
    if (await HttpService().setStatus(
        hubID: hubID, ieeeAddress: device.ieeeAddress, command: command)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> turnOffLightDevice(DeviceLight device) async {
    String command = '{"state": "off"}';
    int hubID = HomeHive.instance.getHomeFromID(RoomHive.instance.getRoomFromID(device.roomID).homeID).hubID;
    if (await HttpService().setStatus(
        hubID: hubID, ieeeAddress: device.ieeeAddress, command: command)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> setColdLightDevice(DeviceLight device) async {
    String command = '{"color_temp": "200"}';
    int hubID = HomeHive.instance.getHomeFromID(RoomHive.instance.getRoomFromID(device.roomID).homeID).hubID;
    if (await HttpService().setStatus(
        hubID: hubID, ieeeAddress: device.ieeeAddress, command: command)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> setHotLightDevice(DeviceLight device) async {
    String command = '{"color_temp": "400"}';
    int hubID = HomeHive.instance.getHomeFromID(RoomHive.instance.getRoomFromID(device.roomID).homeID).hubID;
    if (await HttpService().setStatus(
        hubID: hubID, ieeeAddress: device.ieeeAddress, command: command)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> setBrightnessLightDevice(
      DeviceLight device, int brightness) async {
    String command = '{"brightness": "$brightness"}';
    int hubID = HomeHive.instance.getHomeFromID(RoomHive.instance.getRoomFromID(device.roomID).homeID).hubID;
    if (await HttpService().setStatus(
        hubID: hubID, ieeeAddress: device.ieeeAddress, command: command)) {
      return true;
    } else {
      return false;
    }
  }
}
