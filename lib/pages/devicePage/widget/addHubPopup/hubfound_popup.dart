import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HubFoundPopup extends StatefulWidget {
  final void Function(int)? toggleCallback;
  const HubFoundPopup({super.key, this.toggleCallback});

  @override
  State<HubFoundPopup> createState() => _HubFoundPopupState();
}

class _HubFoundPopupState extends State<HubFoundPopup> {
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
              "SmartLinx Hub",
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
            Image.asset('assets/images/hub.png', height: 700.h,).animate().fade(duration: 700.ms, delay: 100.ms),
            SizedBox(
              height: 100.h,
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
                  widget.toggleCallback!(2);
                },
                child: Text(
                  'Aggiungi alla casa',
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
    ).animate().slideX(begin: 1, end: 0, duration: const Duration(milliseconds: 300));
  }
}
