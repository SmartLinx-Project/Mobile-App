import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
        height: 1700.h,
        padding: EdgeInsets.symmetric(horizontal: 170.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 70.h,
            ),
            Text(
              "Aggiungi Hub",
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
              "Per Iniziare la configurazione inquadra con la fotocamera  il Codice QR posto sotto il tuo Hub",
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
              height: 20.h,
            ),
            SvgPicture.asset(
              'assets/svg/scan.svg',
              // ignore: deprecated_member_use
              color: Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(0.7),
              height: 700.h,
            ).animate().fade(duration: 700.ms, delay: 0.ms),
            SizedBox(
              height: 20.h,
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