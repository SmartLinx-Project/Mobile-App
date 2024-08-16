import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/infoRoutine/widget/action.dart';
import 'package:smartlinx/services/hiveMethod/device_light_hive.dart';
import 'package:smartlinx/services/hiveMethod/device_plug_hive.dart';
import 'package:smartlinx/services/hiveMethod/room_hive.dart';
import '../../../services/hive.dart';
import '../../newRoutine/selDevicePage.dart';

class RoutineActionWidget extends StatefulWidget {
  final Routine routine;
  const RoutineActionWidget({super.key, required this.routine});

  @override
  State<RoutineActionWidget> createState() => _RoutineActionWidgetState();
}

class _RoutineActionWidgetState extends State<RoutineActionWidget> {
  List<Widget> actionsWidget = [];

  List<RoutineObject> fromJsonString(String jsonString) {
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    List<dynamic> jsonList = jsonMap['actions'];
    List<RoutineObject> routines = [];

    for (var item in jsonList) {
      RoutineObject routine = RoutineObject();
      routine.deviceID = int.parse(item['deviceID'].toString());
      routine.action = (item['value'].toString() == 'true') ? true : false;
      routines.add(routine);
    }
    return routines;
  }

  bool checkDeviceType(int deviceID){
    List<DeviceLight> lights = DeviceLightHive.instance.getAllDevices();
    List<DevicePlug> plugs = DevicePlugHive.instance.getAllDevices();
    for(DeviceLight thisLight in lights){
      if(thisLight.deviceID == deviceID){
        return true;
      }
    }
    return false;
  }

  void fillActions() {
    actionsWidget = [];
    List<RoutineObject> routines = fromJsonString(widget.routine.body);
    for (int i = 0; i < routines.length; i++) {
      RoutineObject routine = routines[i];
      actionsWidget.add(
        SingleRoutineAction(
          deviceName: deviceName(routine.deviceID),
          roomName: roomName(routine.deviceID),
          iconPath: (checkDeviceType(routine.deviceID))
              ? 'assets/svg/light.svg'
              : 'assets/svg/plug.svg',
          action: (routine.action) ? 'Accendi' : 'Spegni',
        ),
      );
      actionsWidget.add(
        SizedBox(
          height: MediaQuery.of(context).size.height / 60,
        ),
      );
    }
  }

  String roomName(int deviceID) {
    int roomID = 0;
    List<DeviceLight> lightDevices = DeviceLightHive.instance.getAllDevices();
    List<DevicePlug> plugDevices = DevicePlugHive.instance.getAllDevices();
    for (int i = 0; i < lightDevices.length; i++) {
      if (lightDevices[i].deviceID == deviceID) {
        roomID = lightDevices[i].roomID;
      }
    }
    for (int i = 0; i < plugDevices.length; i++) {
      if (plugDevices[i].deviceID == deviceID) {
        roomID = plugDevices[i].roomID;
      }
    }
    String roomName = RoomHive.instance.getRoomFromID(roomID).name;
    return roomName;
  }

  int deviceType(int deviceID) {
    int deviceType = 0;
    List<DeviceLight> lightDevices = DeviceLightHive.instance.getAllDevices();
    List<DevicePlug> plugDevices = DevicePlugHive.instance.getAllDevices();
    for (int i = 0; i < lightDevices.length; i++) {
      if (lightDevices[i].deviceID == deviceID) {
        deviceType = 0;
      }
    }
    for (int i = 0; i < plugDevices.length; i++) {
      if (plugDevices[i].deviceID == deviceID) {
        deviceType = 1;
      }
    }
    return deviceType;
  }

  String deviceName(int deviceID) {
    String deviceName = '';
    List<DeviceLight> lightDevices = DeviceLightHive.instance.getAllDevices();
    List<DevicePlug> plugDevices = DevicePlugHive.instance.getAllDevices();
    for (int i = 0; i < lightDevices.length; i++) {
      if (lightDevices[i].deviceID == deviceID) {
        deviceName = lightDevices[i].name;
      }
    }
    for (int i = 0; i < plugDevices.length; i++) {
      if (plugDevices[i].deviceID == deviceID) {
        deviceName = plugDevices[i].name;
      }
    }
    return deviceName;
  }

  @override
  Widget build(BuildContext context) {
    fillActions();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 50.w,
            ),
            Text(
              'Azioni',
              style: TextStyle(
                color: Theme.of(context).textTheme.displayLarge?.color,
                fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 90.sp,
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 28,
        ),
        Column(
          children: actionsWidget,
        )
      ],
    );
  }
}
