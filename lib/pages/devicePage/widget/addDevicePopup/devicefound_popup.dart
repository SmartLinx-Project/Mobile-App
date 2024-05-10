import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/http.dart';

class DeviceFound extends StatefulWidget {
  final void Function(int)? toggleCallback;
  final Map<String, dynamic> device;
  const DeviceFound({super.key, this.toggleCallback, required this.device});

  @override
  State<DeviceFound> createState() => _DeviceFoundState();
}

class _DeviceFoundState extends State<DeviceFound> {

  String lottieAsset = '';
  bool clicked = false;

  void checkType(){
    if(widget.device['type'] == 'light'){
      lottieAsset = 'assets/lottie/light_found.json';
    } else if(widget.device['type'] == 'switch'){
      lottieAsset = 'assets/lottie/plug.json';
    } else if(widget.device['type'] == 'thermometer'){
      lottieAsset = 'assets/lottie/thermometer.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    checkType();
    return SafeArea(
      child: Container(
        height: 1500.h,
        padding: EdgeInsets.symmetric(horizontal: 170.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 70.h,
            ),
            Text(
              widget.device['model'],
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
                height: (widget.device['type'] == 'thermometer') ? 50.h : 0.h
            ),
            Lottie.asset(lottieAsset,
                repeat: false, height: (widget.device['type'] == 'thermometer') ? 620.h : 700.h),
            SizedBox(
              height: 120.h,
            ),
            Container(
              width: double.infinity,
              height: 200.h,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.3), // Colore e opacità dell'ombra
                    offset: const Offset(0, 3), // Direzione dell'ombra (dx, dy)
                    blurRadius: 6, // Raggio di sfocatura
                    spreadRadius: 0, // Espansione dell'ombra
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  clicked = true;
                  widget.toggleCallback!(4);
                },
                child: Text(
                  'Aggiungi',
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 75.sp,
                    color: Colors.white,
                  ),
                ),
              ),
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

  @override
  void dispose() {
    if(!clicked){
      HttpService().leaveDevice(
          hubID: HomeHive.instance
              .getHomeFromID(HomeHive.instance.getCurrentHome()!)
              .hubID,
          ieeeAddress: widget.device['ieeeAddress']);
    }
    super.dispose();
  }
}
