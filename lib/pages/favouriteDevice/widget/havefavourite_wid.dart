import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/devicePage/widget/device_light_wid.dart';
import 'package:smartlinx/pages/devicePage/widget/device_plug_wid.dart';
import 'package:smartlinx/pages/devicePage/widget/device_thermostat_wid.dart';
import 'package:smartlinx/services/hiveMethod/device_light_hive.dart';
import 'package:smartlinx/services/hiveMethod/device_thermostat_hive.dart';
import 'package:smartlinx/services/hiveMethod/favourite_hive.dart';
import '../../../services/hive.dart';
import '../../../services/hiveMethod/device_plug_hive.dart';

class HaveFavouriteDeviceWidget extends StatefulWidget {
  final Function refreshPage;
  const HaveFavouriteDeviceWidget({super.key, required this.refreshPage});

  @override
  State<HaveFavouriteDeviceWidget> createState() =>
      _HaveFavouriteDeviceWidgetState();
}

class _HaveFavouriteDeviceWidgetState extends State<HaveFavouriteDeviceWidget> {
  late List<Widget> devicesWidget = [];

  void fillDevices() {
    List<Favourite> favourite = FavouriteHive.instance.getAllFavourite();
    List<DeviceLight> deviceLight = DeviceLightHive.instance.getAllDevices();
    List<DevicePlug> devicePlug = DevicePlugHive.instance.getAllDevices();
    List<DeviceThermostat> deviceThermostat =
        DeviceThermostatHive.instance.getAllDevices();
    devicesWidget.clear();
    for (int i = 0; i < favourite.length; i++) {
      for (int a = 0; a < deviceLight.length; a++) {
        if (favourite[i].deviceID == deviceLight[a].deviceID) {
          DeviceLight filteredDevice = deviceLight[a];
          devicesWidget.add(DeviceLightWidget(
            device: filteredDevice,
            refreshPage: widget.refreshPage,
          ));
        }
      }
      for (int a = 0; a < devicePlug.length; a++) {
        if (favourite[i].deviceID == devicePlug[a].deviceID) {
          DevicePlug filteredDevice = devicePlug[a];
          devicesWidget.add(DevicePlugWidget(device: filteredDevice, refreshPage: widget.refreshPage,));
        }
      }
      for (int a = 0; a < deviceThermostat.length; a++) {
        if (favourite[i].deviceID == deviceThermostat[a].deviceID) {
          DeviceThermostat filteredDevice = deviceThermostat[a];
          devicesWidget.add(DeviceThermostatWidget(device: filteredDevice, refreshPage: widget.refreshPage,));
        }
      }
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
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 700.h,
          crossAxisSpacing: 50.h,
          mainAxisSpacing: 50.h,
          mainAxisExtent: 400.h),
      itemCount: devicesWidget.length,
      itemBuilder: (context, index) {
        return devicesWidget[index];
      },
    );
  }
}
