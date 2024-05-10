import 'package:smartlinx/services/hive.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/http.dart';

import '../../services/hiveMethod/room_hive.dart';

class SmartPlugLogic {
  Future<bool> turnOnPlugDevice(DevicePlug device) async {
    String command = '{"state": "on"}';
    int hubID = HomeHive.instance.getHomeFromID(RoomHive.instance.getRoomFromID(device.roomID).homeID).hubID;
    if (await HttpService().setStatus(
        hubID: hubID, ieeeAddress: device.ieeeAddress, command: command)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> turnOffPlugDevice(DevicePlug device) async {
    String command = '{"state": "off"}';
    int hubID = HomeHive.instance.getHomeFromID(RoomHive.instance.getRoomFromID(device.roomID).homeID).hubID;
    if (await HttpService().setStatus(
        hubID: hubID, ieeeAddress: device.ieeeAddress, command: command)) {
      return true;
    } else {
      return false;
    }
  }
}
