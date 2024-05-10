import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/services/hive.dart';
import 'package:smartlinx/services/hiveMethod/device_light_hive.dart';
import 'package:smartlinx/services/hiveMethod/favourite_hive.dart';
import 'package:smartlinx/services/http.dart';
import '../../../services/hiveMethod/device_plug_hive.dart';
import '../../../services/hiveMethod/device_thermostat_hive.dart';

// Widget per la barra del menu
class MenuBarItems extends StatelessWidget {
  final int deviceID;
  final int type;
  final Function refreshPage;
  const MenuBarItems(
      {super.key,
      required this.deviceID,
      required this.type,
      required this.refreshPage});

  addFavourite() async {
    List<Favourite> favourites = FavouriteHive.instance.getAllFavourite();
    bool found = false;
    for (int i = 0; i < favourites.length; i++) {
      if (favourites[i].deviceID == deviceID) {
        found = true;
        break;
      }
    }

    if (found) {
      if (await HttpService().delFavourite(deviceID: deviceID)) {
        await FavouriteHive.instance.deleteFavourite(deviceID);
        refreshPage();
      }
    } else {
      HttpService().addFavourite(deviceID: deviceID);
      FavouriteHive.instance.newFavourite(Favourite(deviceID: deviceID));
      refreshPage();
    }
  }

  removeDevice() async {
    if (await HttpService().delDevice(deviceID: deviceID)) {
      switch (type) {
        case 0:
          await DeviceLightHive.instance.removeDevice(deviceID);
          break;
        case 1:
          await DevicePlugHive.instance.removeDevice(deviceID);
          break;
        case 2:
          await DeviceThermostatHive.instance.removeDevice(deviceID);
          break;
      }
    }
    refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 55.w,
          ),
          GestureDetector(
            onTap: () {
              addFavourite();
              Navigator.pop(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  size: 80.sp,
                  color: Theme.of(context).iconTheme.color!.withOpacity(0.9),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Preferiti',
                  style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .color!
                          .withOpacity(0.9),
                      fontSize: 40.sp),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            height: 140.h,
            width: 2,
            color: Theme.of(context).iconTheme.color!.withOpacity(0.4),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              removeDevice();
              Navigator.pop(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete,
                  size: 80.sp,
                  color: Theme.of(context).iconTheme.color!.withOpacity(0.9),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Elimina',
                  style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .color!
                          .withOpacity(0.9),
                      fontSize: 40.sp),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 55.w,
          )
        ],
      ),
    );
  }
}
