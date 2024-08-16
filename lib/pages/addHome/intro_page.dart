import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/addHome/widget/addhome_button1.dart';
import 'package:smartlinx/pages/addHome/widget/addhome_button2.dart';


class AddHomeIntroPage extends StatelessWidget {
  const AddHomeIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 100.w),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 350.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vuoi aggiungere\n una casa?",
                      style: TextStyle(
                        fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
                        color: Theme.of(context).textTheme.displayLarge?.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 130.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(
                  height: 280.h,
                ),
                Center(
                  child: Image.asset('assets/images/addhome.png', height: 1000.h,),
                ),
                SizedBox(
                  height: 280.h,
                ),
                const AddHomebutton1(),
                SizedBox(
                  height: 100.h,
                ),
                const AddHomebutton2(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}