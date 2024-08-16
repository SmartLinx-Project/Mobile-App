import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/newRoutine/selMode.dart';
import 'package:smartlinx/pages/newRoutine/widget/deviceDialog.dart';
import 'package:smartlinx/services/hiveMethod/device_light_hive.dart';
import 'package:smartlinx/services/hiveMethod/device_plug_hive.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/hiveMethod/room_hive.dart';
import '../../services/hive.dart';

class SelectDevicePage extends StatefulWidget {
  Routine? previousRoutine;
  SelectDevicePage({super.key, this.previousRoutine});

  @override
  State<SelectDevicePage> createState() => _SelectDevicePageState();
}

class _SelectDevicePageState extends State<SelectDevicePage> {
  List<Widget> widgetList = [];
  List<RoutineObject> routines = [];

  void checkPreviousRoutine() {
    routines = [];
    if (widget.previousRoutine != null) {
      Map<String, dynamic> jsonMap = jsonDecode(widget.previousRoutine!.body);
      List<dynamic> jsonList = jsonMap['actions'];

      for (var item in jsonList) {
        RoutineObject routine = RoutineObject();
        routine.deviceID = int.parse(item['deviceID'].toString());
        routine.action = item['value'].toString() == 'true';
        routines.add(routine);
      }
    }
  }

  RoutineObject? getPreviousValue(int deviceID) {
    for (RoutineObject action in routines) {
      if (action.deviceID == deviceID) {
        return action;
      }
    }
    return null;
  }

  void fillWidgets() {
    int currentHome = HomeHive.instance.getCurrentHome()!;
    List<Room> rooms = RoomHive.instance.getRoomsFromHomeID(currentHome);
    List<DeviceLight> lightDevices = DeviceLightHive.instance.getAllDevices();
    List<DevicePlug> plugDevices = DevicePlugHive.instance.getAllDevices();
    widgetList = [];

    widgetList.add(
      SizedBox(
        height: 200.h,
      ),
    );

    for (int i = 0; i < rooms.length; i++) {
      if (checkAvailableDevices(rooms[i].roomID)) {
        widgetList.add(
          Row(
            children: [
              SizedBox(
                width: 50.w,
              ),
              Text(
                rooms[i].name,
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.color!
                      .withOpacity(0.7),
                  fontFamily:
                      Theme.of(context).textTheme.displayLarge?.fontFamily,
                  fontWeight: FontWeight.normal,
                  fontSize: 50.sp,
                ),
                textAlign: TextAlign.left,
              ),
              const Spacer(),
            ],
          ),
        );
        widgetList.add(
          SizedBox(
            height: 70.h,
          ),
        );
        for (int a = 0; a < lightDevices.length; a++) {
          if (lightDevices[a].roomID == rooms[i].roomID) {
            RoutineObject? action = getPreviousValue(lightDevices[a].deviceID);
            if (action != null) {
              print('deviceID: ' + action!.deviceID.toString());
            }
            widgetList.add(
              RoutineDeviceDialog(
                deviceName: lightDevices[a].name,
                deviceType: 0,
                deviceID: lightDevices[a].deviceID,
                addRoutine: addRoutine,
                removeRoutine: removeRoutine,
                initialSelected: (action != null) ? true : false,
                initialState: (action != null) ? action.action : false,
              ),
            );
            widgetList.add(
              SizedBox(
                height: 50.h,
              ),
            );
          }
        }
        for (int a = 0; a < plugDevices.length; a++) {
          if (plugDevices[a].roomID == rooms[i].roomID) {
            RoutineObject? action = getPreviousValue(plugDevices[a].deviceID);
            widgetList.add(
              RoutineDeviceDialog(
                deviceName: plugDevices[a].name,
                deviceType: 1,
                deviceID: plugDevices[a].deviceID,
                addRoutine: addRoutine,
                removeRoutine: removeRoutine,
                initialSelected: (action != null) ? true : false,
                initialState: (action != null) ? action.action : false,
              ),
            );
            widgetList.add(
              SizedBox(
                height: 50.h,
              ),
            );
          }
        }
      }
    }
  }

  bool checkAvailableDevices(int roomID) {
    List<DeviceLight> lightDevices = DeviceLightHive.instance.getAllDevices();
    List<DevicePlug> plugDevices = DevicePlugHive.instance.getAllDevices();
    bool light = false;
    bool plug = false;

    for (int i = 0; i < lightDevices.length; i++) {
      if (lightDevices[i].roomID == roomID) {
        light = true;
        break;
      }
    }
    for (int i = 0; i < plugDevices.length; i++) {
      if (plugDevices[i].roomID == roomID) {
        plug = true;
        break;
      }
    }
    if (light || plug) {
      return true;
    } else {
      return false;
    }
  }

  void addRoutine(RoutineObject routine) {
    routines.add(routine);
    setState(() {});
  }

  void removeRoutine(RoutineObject routine) {
    for (int i = 0; i < routines.length; i++) {
      if (routines[i]._deviceID == routine._deviceID) {
        routines.remove(routines[i]);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    checkPreviousRoutine();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fillWidgets();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).textTheme.displayLarge?.color,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Seleziona dispositivi',
          style: TextStyle(
            color: Theme.of(context).textTheme.displayLarge?.color,
            fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
            fontWeight: FontWeight.normal,
            fontSize: 70.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60.w),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.32,
              child: SingleChildScrollView(
                child: Column(
                  children: widgetList,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
              child: SingleChildScrollView(
                child: Column(
                  children: widgetList,
                ),
              ),
            ),
            Container(
              width: 850.w,
              height: 180.h,
              decoration: BoxDecoration(
                color: (routines.isNotEmpty)
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withOpacity(0.6),
                borderRadius: BorderRadius.circular(150.r),
              ),
              child: TextButton(
                onPressed: () async {
                  if (routines.isNotEmpty) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            SelectRoutineMode(
                          devices: routines,
                          previousRoutine: (widget.previousRoutine != null)
                              ? widget.previousRoutine
                              : null,
                        ),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  }
                },
                child: Text(
                  'Successivo',
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 68.sp,
                    color: (routines.isNotEmpty)
                        ? Colors.white
                        : Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoutineObject {
  late int _deviceID;
  late bool _action;

  int get deviceID => _deviceID;

  set deviceID(int value) {
    _deviceID = value;
  }

  bool get action => _action;

  set action(bool value) {
    _action = value;
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceID': _deviceID,
      'value': _action,
    };
  }
}
