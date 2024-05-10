import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smartlinx/pages/selectLogin/selectlogin_page.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        finishButtonText: 'Vai al login',
        onFinish: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SelectLoginPage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        }, //da implementare
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
        ),
        skipTextButton: Text(
          'Salta',
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        controllerColor: Theme.of(context).colorScheme.primary,
        totalPage: 3,
        headerBackgroundColor: Theme.of(context).colorScheme.background,
        pageBackgroundColor: Theme.of(context).colorScheme.background,
        background: [
          Padding(
            padding: EdgeInsets.only(top: 200.sp),
            child: Image.asset(
              'assets/images/onboarding1.png',
              height: 1000.sp,
            ),
          ).animate().fade(duration: 700.ms, delay: 0.ms),
          Padding(
            padding: EdgeInsets.only(top: 200.sp, left: 160.sp),
            child: Image.asset(
              'assets/images/onboarding2.png',
              height: 1000.sp,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 200.sp, left: 25.sp),
            child: Image.asset(
              'assets/images/onboarding3.png',
              height: 1000.sp,
            ),
          ),
        ],
        speed: 1.8,
        pageBodies: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 1300.sp,
                ),
                Text(
                  'Controlla i tuoi dispositivi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 115.sp,
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    fontFamily:
                    Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 120.sp,
                ),
                Text(
                  'Porta il controllo dei tuoi dispositivi direttamente nelle tue mani. Grazie alla nostra app',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 60.sp,
                    color: Theme.of(context).textTheme.displayMedium?.color,
                    fontFamily:
                    Theme.of(context).textTheme.displayMedium?.fontFamily,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ).animate().fade(duration: 700.ms, delay: 0.ms),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 1300.sp,
                ),
                Text(
                  'Sincronizza con il tuo account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 115.sp,
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    fontFamily:
                    Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 120.sp,
                ),
                Text(
                  ' Connetti i tuoi dispositivi al tuo profilo per avere accesso istantaneo a tutte le tue preferenze e impostazioni. ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 60.sp,
                    color: Theme.of(context).textTheme.displayMedium?.color,
                    fontFamily:
                    Theme.of(context).textTheme.displayMedium?.fontFamily,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 1300.sp,
                ),
                Text(
                  'Automazione',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 115.sp,
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    fontFamily:
                    Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 120.sp,
                ),
                Text(
                  'La nostra app ti consente di automatizzare le azioni quotidiane dei tuoi dispositivi. Configura facilmente scenari personalizzati.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 60.sp,
                    color: Theme.of(context).textTheme.displayMedium?.color,
                    fontFamily:
                    Theme.of(context).textTheme.displayMedium?.fontFamily,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
