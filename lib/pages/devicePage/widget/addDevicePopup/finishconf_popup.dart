import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartlinx/services/hiveMethod/room_hive.dart';

class FinishConfPopup extends StatefulWidget {
  final void Function(int)? toggleCallback;
  final String deviceName;
  final Map<String, dynamic> device;
  const FinishConfPopup(
      {super.key, required this.toggleCallback, required this.deviceName, required this.device});
  @override
  State<FinishConfPopup> createState() => _FinishConfPopupState();
}

class _FinishConfPopupState extends State<FinishConfPopup> {
  String roomName =
      RoomHive.instance.getRoomFromID(RoomHive.instance.getCurrentRoom()!).name;

  String imageAsset = '';

  void checkType(){
    if(widget.device['type'] == 'light'){
      imageAsset = 'assets/svg/light_bulb.svg';
    } else if(widget.device['type'] == 'switch'){
      imageAsset = 'assets/svg/smart-plug.svg';
    } else if(widget.device['type'] == 'thermometer'){
      imageAsset = 'assets/svg/thermometer.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    checkType();
    return SafeArea(
      child: Container(
        height: 1900.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 170.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 100.h,
            ),
            Text(
              "Dispositivo Aggiunto",
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
              height: 150.h,
            ),
            SvgPicture.asset(
              imageAsset,
              color: Theme.of(context).iconTheme.color!.withOpacity(0.7),
              height: 600.h,
            ),
            SizedBox(
              height: 200.h,
            ),
            Text(
              'Dispositivo: ${widget.deviceName}',
              style: TextStyle(
                fontFamily:
                    Theme.of(context).textTheme.displayMedium?.fontFamily,
                color: Theme.of(context).textTheme.displayMedium?.color,
                fontWeight: FontWeight.normal,
                fontSize: 65.sp,
              ),
              textAlign: TextAlign.center,
            ).animate().fade(duration: 700.ms, delay: 100.ms),
            SizedBox(
              height: 30.h,
            ),
            Text(
              'Stanza: $roomName',
              style: TextStyle(
                fontFamily:
                    Theme.of(context).textTheme.displayMedium?.fontFamily,
                color: Theme.of(context).textTheme.displayMedium?.color,
                fontWeight: FontWeight.normal,
                fontSize: 65.sp,
              ),
              textAlign: TextAlign.center,
            ).animate().fade(duration: 700.ms, delay: 100.ms),
            SizedBox(
              height: 120.h,
            ),
            Container(
              width: 440.w,
              height: 150.h,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
                borderRadius: BorderRadius.circular(150.r),
              ),
              child: TextButton(
                onPressed: () {
                  widget.toggleCallback!(7);
                },
                child: Text(
                  'Chiudi',
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.normal,
                    fontSize: 60.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80.h,
            ),
          ],
        ),
      ),
    )
        .animate()
        .slideX(begin: 1, end: 0, duration: const Duration(milliseconds: 300));
  }
}
