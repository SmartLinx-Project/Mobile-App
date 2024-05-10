import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/http.dart';

class ScanDevice extends StatefulWidget {
  final void Function(int)? toggleCallback;
  final Function setFindDevice;
  const ScanDevice(
      {super.key, this.toggleCallback, required this.setFindDevice});

  @override
  State<ScanDevice> createState() => _ScanDeviceState();
}

class _ScanDeviceState extends State<ScanDevice> {
  @override
  void initState() {
    super.initState();
    scanDevice();
  }

  void scanDevice() async {
    int hubID = HomeHive.instance
        .getHomeFromID(HomeHive.instance.getCurrentHome()!)
        .hubID;
    Map<String, dynamic> findDevice =
        await HttpService().joinDevice(hubID: hubID);
    if (findDevice.isNotEmpty) {
      widget.setFindDevice(findDevice);
      widget.toggleCallback!(3);
    } else {}
  }

  void disableJoin() {
    HttpService().disableJoin(
        hubID: HomeHive.instance
            .getHomeFromID(HomeHive.instance.getCurrentHome()!)
            .hubID);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 1500.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 170.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 130.h,
            ),
            Text(
              "Aggiungi Dispositivo",
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
              height: 200.h,
            ),
            LoadingAnimationWidget.staggeredDotsWave(
                color: Theme.of(context).colorScheme.primary, size: 350.sp),
            SizedBox(
              height: 100.h,
            ),
            TextButton(
              onPressed: () {
              },
              child: Text(
                'Ricerca in corso...',
                style: TextStyle(
                  fontFamily:
                      Theme.of(context).textTheme.displayMedium?.fontFamily,
                  fontWeight: FontWeight.normal,
                  fontSize: 80.sp,
                  color: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.color!
                      .withOpacity(0.9),
                ),
              ),
            ),
            SizedBox(
              height: 120.h,
            ),
            Container(
              width: 440.w,
              height: 150.h,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                borderRadius: BorderRadius.circular(150.r),
              ),
              child: TextButton(
                onPressed: () {
                  disableJoin();
                  widget.toggleCallback!(7);
                },
                child: Text(
                  'Chiudi',
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.normal,
                    fontSize: 60.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .slideX(begin: 1, end: 0, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    disableJoin();
  }
}
