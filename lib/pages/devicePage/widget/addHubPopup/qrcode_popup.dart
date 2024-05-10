import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrcodePopup extends StatefulWidget {
  final void Function(int)? toggleCallback;
  Function setHubID;
  QrcodePopup({super.key, this.toggleCallback, required this.setHubID});

  @override
  State<QrcodePopup> createState() => _QrcodePopupState();
}

class _QrcodePopupState extends State<QrcodePopup> {

  bool qrFound = false;

  void manageCode(String code) async{
    Map<String, dynamic> jsonCode = jsonDecode(code);

    if(jsonCode.containsKey('hubID')) {
      int hubID = int.parse(jsonCode['hubID']);

      setState(() {
        qrFound = true;
      });
      await Future.delayed(const Duration(milliseconds: 2500));
      widget.setHubID(hubID);
      widget.toggleCallback!(4);
    } else {
      widget.toggleCallback!(5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 2600.h,
        padding: EdgeInsets.symmetric(horizontal: 170.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 130.h,
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
              "Inquadra il QR Code posto sull’etichetta sottostante al Hub",
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
              height: 120.h,
            ),
          Container(
            height: 1500.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70.r),
              color: Colors.grey,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(70.r),
              child: Stack(
                children: [
                  MobileScanner(
                    allowDuplicates: false,
                    onDetect: (barcode, args){
                      if (barcode.rawValue == null) {
                        debugPrint('Failed to scan Barcode');
                      } else {
                        final String code = barcode.rawValue!;
                        manageCode(code);
                      }
                    },
                  ),

                  if(!qrFound)
                  Center(
                    child: SvgPicture.asset('assets/svg/scan_area.svg', height: 650.h, ),
                  ),
                  if(qrFound)
                    Center(
                      child: Lottie.asset('assets/lottie/check.json', height: 400.h, repeat: false),
                    ),
                ],
              ),
            ),
          ).animate().fade(duration: 700.ms, delay: 0.ms),
            SizedBox(
              height: 50.h,
            ),
            TextButton(
              onPressed: () {
              },
              child: Text(
                'Dispositivo non trovato?',
                style: TextStyle(
                  fontFamily:
                      Theme.of(context).textTheme.displayLarge?.fontFamily,
                  fontWeight: FontWeight.normal,
                  fontSize: 55.sp,
                  color: Theme.of(context).textTheme.displayLarge?.color,
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
