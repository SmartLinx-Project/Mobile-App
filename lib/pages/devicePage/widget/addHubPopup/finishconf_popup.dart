import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinishConfPopup extends StatefulWidget {

  final void Function(int)? toggleCallback;
  const FinishConfPopup({super.key, required this.toggleCallback});
  @override
  State<FinishConfPopup> createState() => _FinishConfPopupState();
}

class _FinishConfPopupState extends State<FinishConfPopup> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 1400.h,
        padding: EdgeInsets.symmetric(horizontal: 170.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 180.h,
            ),
            Text(
              "Hai finito!",
              style: TextStyle(
                fontFamily:
                Theme.of(context).textTheme.displayLarge?.fontFamily,
                color: Theme.of(context).textTheme.displayLarge?.color,
                fontWeight: FontWeight.w500,
                fontSize: 150.sp,
              ),
              textAlign: TextAlign.center,
            ).animate().fade(duration: 700.ms, delay: 100.ms),
            SizedBox(
              height: 130.h,
            ),
            Text(
              "SmartLinx Hub configurato \ncon successo",
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
              height: 170.h,
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
                  'Chiudi',
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
    ).animate().slideX(begin: 1, end: 0, duration: const Duration(milliseconds: 300));
  }
}
