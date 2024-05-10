import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ErrorAddDevicePopup extends StatefulWidget {
  final void Function(int)? toggleCallback;
  const ErrorAddDevicePopup({super.key, required this.toggleCallback});
  @override
  State<ErrorAddDevicePopup> createState() => _ErrorAddDevicePopupState();
}

class _ErrorAddDevicePopupState extends State<ErrorAddDevicePopup> {
  @override
  Widget build(BuildContext context) {
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
              "Impossibile aggiungere dispositivo",
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
            Container(
              child: Lottie.asset('assets/lottie/error.json', height: 450.sp, repeat: false),
            ).animate().fade(duration: 700.ms, delay: 0.ms),
            SizedBox(
              height: 150.h,
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
                  widget.toggleCallback!(7);
                },
                child: Text(
                  'Torna alla home',
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 75.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 120.h,
            ),
          ],
        ),
      ),
    )
        .animate()
        .slideX(begin: 1, end: 0, duration: const Duration(milliseconds: 300));
  }
}
