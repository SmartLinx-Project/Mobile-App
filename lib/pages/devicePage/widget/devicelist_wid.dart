import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/hive.dart';
import '../../../services/hiveMethod/device_light_hive.dart';
import '../../../services/hiveMethod/device_plug_hive.dart';
import '../../../services/hiveMethod/device_thermostat_hive.dart';
import 'device_light_wid.dart';
import 'device_plug_wid.dart';
import 'device_thermostat_wid.dart';

class DeviceListWidget extends StatefulWidget {
  final int roomID;
  final Function refreshDevicePage;

  const DeviceListWidget({super.key, required this.roomID, required this.refreshDevicePage});

  @override
  State<DeviceListWidget> createState() => _DeviceListWidgetState();
}

class _DeviceListWidgetState extends State<DeviceListWidget> {
  List<Widget> devices = [];

  void fillDevices() {
    devices.clear();
    List<DeviceLight> deviceLight =
        DeviceLightHive.instance.getDevicesFromRoomID(widget.roomID);
    List<DevicePlug> devicePlug =
        DevicePlugHive.instance.getDevicesFromRoomID(widget.roomID);
    List<DeviceThermostat> deviceThermostat =
        DeviceThermostatHive.instance.getDevicesFromRoomID(widget.roomID);

    for (int a = 0; a < deviceLight.length; a++) {
      DeviceLight filteredDevice = deviceLight[a];
      devices.add(DeviceLightWidget(device: filteredDevice, refreshPage: widget.refreshDevicePage,));
    }
    for (int a = 0; a < devicePlug.length; a++) {
      DevicePlug filteredDevice = devicePlug[a];
      devices.add(DevicePlugWidget(device: filteredDevice, refreshPage: widget.refreshDevicePage,));
    }
    for (int a = 0; a < deviceThermostat.length; a++) {
      DeviceThermostat filteredDevice = deviceThermostat[a];
      devices.add(DeviceThermostatWidget(device: filteredDevice, refreshPage: widget.refreshDevicePage,));
    }
  }

  @override
  void initState() {
    fillDevices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fillDevices();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 110.w),
      child: (devices.isNotEmpty)
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 700.h,
                  crossAxisSpacing: 50.h,
                  mainAxisSpacing: 50.h,
                  mainAxisExtent: 400.h),
              itemCount: devices.length,
              itemBuilder: (context, index) {
                return devices[index];
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.device_hub_rounded,
                    size: 120.sp,
                    color: Theme.of(context).iconTheme.color!.withOpacity(0.9),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    'Nessun dispositivo',
                    style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .color!
                            .withOpacity(0.9),
                        fontSize: 75.sp),
                  ),
                ],
              ),
            ),
    );
  }
}
