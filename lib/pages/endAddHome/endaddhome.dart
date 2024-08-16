import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/endAddHome/widget/vaibtn.dart';

class EndAddHome extends StatefulWidget {
  const EndAddHome({super.key});

  @override
  State<EndAddHome> createState() => _EndAddHomeState();
}

class _EndAddHomeState extends State<EndAddHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 200.h, left: 20.w, right: 20.w),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 200.h, bottom: 100.h),
                  child: Text(
                    "Hai Finito!",
                    style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.displayLarge?.fontFamily,
                      color: Theme.of(context).textTheme.displayLarge?.color,
                      fontWeight: FontWeight.w500,
                      fontSize: 150.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 75.h),
                Image(
                  image: const AssetImage("assets/images/haiFinito.png"),
                  width: 1000.w,
                  height: 1000.w,
                ),
                SizedBox(height: 100.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Text(
                    "Congratulazioni! Hai completato la configurazione della tua casa con successo.\n"
                    "Ora puoi godere di tutte le funzionalità presenti sull’app.",
                    style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.displayLarge?.fontFamily,
                      color: Theme.of(context).textTheme.displayLarge?.color,
                      fontWeight: FontWeight.normal,
                      fontSize: 65.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 250.h),
                const VaiBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
