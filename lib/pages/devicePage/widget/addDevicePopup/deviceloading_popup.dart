import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/hiveMethod/room_hive.dart';
import 'package:smartlinx/services/http.dart';
import 'package:smartlinx/services/init_app.dart';

class DeviceLoadingPopup extends StatefulWidget {
  final void Function(int)? toggleCallback;
  final Map<String, dynamic> deviceInfo;
  final String deviceName;
  const DeviceLoadingPopup(
      {super.key,
      this.toggleCallback,
      required this.deviceName,
      required this.deviceInfo});

  @override
  State<DeviceLoadingPopup> createState() => _DeviceLoadingPopupState();
}

class _DeviceLoadingPopupState extends State<DeviceLoadingPopup> {
  Future<void> _addDevice() async {
    Map<String, dynamic> device = widget.deviceInfo;
    String name = widget.deviceName;
    String ieeeAddress = device['ieeeAddress'];
    String model = device['model'];
    int roomID = RoomHive.instance.getCurrentRoom()!;
    String type = device['type'];
    String setStateCommand =
        '{"state": "ON","brightness": 200, "color_temp": "454"}';
    int hubID = HomeHive.instance
        .getHomeFromID(RoomHive.instance.getRoomFromID(roomID).homeID)
        .hubID;
    if (await HttpService().addDevice(
        name: name,
        ieeeAddress: ieeeAddress,
        model: model,
        roomID: roomID,
        type: type)) {
      if (type == "light") {
        await HttpService().setStatus(
            hubID: hubID, ieeeAddress: ieeeAddress, command: setStateCommand);
      }
      await InitApp().startInit();
      widget.toggleCallback!(6);
    } else {
      HttpService().leaveDevice(hubID: hubID, ieeeAddress: ieeeAddress);
      widget.toggleCallback!(8);
    }
  }

  @override
  void initState() {
    super.initState();
    _addDevice();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 1500.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 170.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 70.h,
            ),
            Text(
              widget.deviceName,
              style: TextStyle(
                fontFamily:
                    Theme.of(context).textTheme.displayLarge?.fontFamily,
                color: Theme.of(context).textTheme.displayLarge?.color,
                fontWeight: FontWeight.w500,
                fontSize: 110.sp,
              ),
              textAlign: TextAlign.center,
            ).animate().fade(duration: 700.ms, delay: 100.ms),
            SizedBox(
              height: 70.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 200.h),
              child: LoadingAnimationWidget.inkDrop(
                color: Theme.of(context).colorScheme.primary,
                size: 300.w,
              ),
            ).animate().fade(duration: 700.ms, delay: 100.ms),
            SizedBox(
              height: 100.h,
            ),
            Text(
              "Aggiunta in corso...",
              style: TextStyle(
                fontFamily:
                    Theme.of(context).textTheme.displayLarge?.fontFamily,
                color: Theme.of(context).textTheme.displayLarge?.color,
                fontWeight: FontWeight.normal,
                fontSize: 90.sp,
              ),
              textAlign: TextAlign.center,
            ).animate().fade(duration: 700.ms, delay: 100.ms),
            SizedBox(
              height: 130.h,
            ),
          ],
        ),
      ),
    )
        .animate()
        .slideX(begin: 1, end: 0, duration: const Duration(milliseconds: 300));
  }
}
