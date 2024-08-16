import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/registerPage/register_page.dart';
import 'package:smartlinx/pages/loginPage/login_page.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.w),
      child: Column(
        children: [
          Text(
            "Gestisci la tua casa con SmartLinx",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 100.sp,
              fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.displayLarge?.color!.withOpacity(0.9),
            ),
          ),
          SizedBox(height: 90.h),
          Text(
            "Con la nostra app intuitiva, puoi prendere il controllo completo della tua abitazione, personalizzando ogni aspetto del tuo ambiente domestico. Regola luci, termostati e altro ancora, il tutto con un tocco sullo schermo del tuo dispositivo.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 55.sp,
              fontFamily: Theme.of(context).textTheme.displayMedium?.fontFamily,
              fontWeight: FontWeight.normal,
              color: Theme.of(context).textTheme.displayMedium?.color!.withOpacity(0.9),
              letterSpacing: 0,
            ),
          ),
          SizedBox(height: 130.0.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => const LoginPage(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      alignment: Alignment.center,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.r),
                          bottomLeft: Radius.circular(50.r),
                        ),
                      ),
                      fixedSize: Size(600.w, 200.h),
                    ),
                    child: Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.background.withOpacity(1),
                          fontSize: 65.sp,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => const RegisterPage(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50.r),
                          bottomRight: Radius.circular(50.r),
                        ),
                      ),
                      fixedSize: Size(600.w, 200.h),
                    ),
                    child: Text(
                      'Registrati',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.displayMedium?.color!.withOpacity(0.9),
                        fontWeight: FontWeight.bold,
                        fontSize: 70.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
