import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smartlinx/pages/homePage/home_page.dart';
import 'package:smartlinx/pages/onBoardingPage/onboarding_page.dart';
import 'package:smartlinx/pages/selectLogin/selectlogin_page.dart';
import 'package:smartlinx/services/init_app.dart';
import 'package:smartlinx/services/local_storage.dart';
import '../../services/auth.dart';
import '../sharedWidget/updater.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool firstTime;
  bool isLogged = false;

  @override
  void initState(){
    super.initState();
    initApp();
  }

  void initApp() async{
    await Updater().checkUpdate(context);
    _redirectToOnboardingPage();
  }

  Future<void> _redirectToOnboardingPage() async {
    await isFirstTime();
    await _checkLogin();
    await InitApp().startInit();
    _redirect();
  }

  Future<void> _checkLogin() async {
    isLogged = await Auth().isUserLoggedIn();
  }

  Future<void> isFirstTime() async {
    bool value = await LocalStorage().getBoolValue('isFirstTime');

    if (value) {
      firstTime = true;
    } else {
      firstTime = false;
    }
  }
  void _redirect() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return StreamBuilder<User?>(
          stream: Auth().authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (isLogged) {
                return const HomePage();
              } else {
                if (firstTime) {
                  return const OnBoardingPage();
                } else {
                  return const SelectLoginPage();
                }
              }
            }
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          Center(
            child: Row(
              children: [
                const Spacer(),
                Text(
                  'Smart',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge?.color,
                      fontSize: 180.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SFProDisplay'),
                ).animate().fade(duration: 1000.ms, delay: 200.ms),
                SizedBox(
                  width: 17.sp,
                ),
                Text(
                  'Linx',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 180.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SFProDisplay'),
                ).animate().fade(duration: 1000.ms, delay: 350.ms),
                const Spacer(),
              ],
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2.2,
            top: MediaQuery.of(context).size.width / 0.66,
            child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
                .animate(delay: const Duration(milliseconds: 2000))
                .fadeIn(duration: const Duration(milliseconds: 300)),
          ),
        ],
      ),
    );
  }
}
