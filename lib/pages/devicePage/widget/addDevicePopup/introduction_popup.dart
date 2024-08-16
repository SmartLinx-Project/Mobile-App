import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class IntroductionPopup extends StatefulWidget {

  final void Function(int)? toggleCallback;
  const IntroductionPopup({super.key, required this.toggleCallback});
  @override
  State<IntroductionPopup> createState() => _IntroductionPopupState();
}

class _IntroductionPopupState extends State<IntroductionPopup> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height:MediaQuery.of(context).size.height * 0.6,
        padding: EdgeInsets.symmetric(horizontal: 170.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 70.h,
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
              height: 70.h,
            ),
            Text(
              "Per Iniziare la configurazione assicurati che il tuo dispositivo sia acceso e in modalità Pairing",
              style: TextStyle(
                fontFamily:
                Theme.of(context).textTheme.displayMedium?.fontFamily,
                color: Theme.of(context).textTheme.displayMedium?.color,
                fontWeight: FontWeight.normal,
                fontSize: 60.sp,
              ),
              textAlign: TextAlign.center,
            ).animate().fade(duration: 700.ms, delay: 100.ms),
            SizedBox(
              height: 100.h,
            ),
            Lottie.asset('assets/lottie/light_bulb.json', height: 550.h, repeat: false),
            SizedBox(
              height: 140.h,
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
                  'Scansiona',
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
    ).animate().fadeIn(duration: const Duration(milliseconds: 400));
  }
}