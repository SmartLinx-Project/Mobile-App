import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/selectLogin/widget/bottom_wid.dart';

class SelectLoginPage extends StatelessWidget {
  const SelectLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: 2200.h,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(180.r),
                  bottomRight: Radius.circular(180.r),
                ),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/Home.png',
                  width: 950.h,
                ),
              ),
            ),
            SizedBox(height: 120.h),
            const BottomWidget()
          ],
        ),
      ).animate().fade(duration: 400.ms, delay: 0.ms),
    );
  }
}
