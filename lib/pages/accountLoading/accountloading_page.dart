import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smartlinx/pages/addHome/intro_page.dart';
import 'package:smartlinx/pages/homePage/home_page.dart';
import 'dart:async';
import '../../services/hiveMethod/home_hive.dart';
import '../../services/init_app.dart';

class AccountLoadingPage extends StatefulWidget {
  const AccountLoadingPage({super.key});

  @override
  AccountLoadingPageState createState() => AccountLoadingPageState();
}

class AccountLoadingPageState extends State<AccountLoadingPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await InitApp().startInit();
    _goToPage();
  }

  void _goToPage() {
    if (HomeHive.instance.getAllHomes().isEmpty) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AddHomeIntroPage()),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 550.h, left: 100.w),
            child: Text(
              'Stiamo caricando il tuo profilo ...',
              style: TextStyle(
                fontFamily:
                    Theme.of(context).textTheme.displayLarge?.fontFamily,
                color: Theme.of(context).textTheme.displayLarge?.color,
                fontWeight: FontWeight.bold,
                fontSize: 100.sp,
              ),
            ),
          ),
          SizedBox(
            height: 650.h,
          ),
          Center(
            child: LoadingAnimationWidget.inkDrop(
              color: Theme.of(context).colorScheme.primary,
              size: 300.w,
            ),
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 550.h),
              child: Text(
                'Ci siamo quasi !',
                style: TextStyle(
                  fontFamily:
                      Theme.of(context).textTheme.displayLarge?.fontFamily,
                  color: Theme.of(context).textTheme.displayLarge?.color,
                  fontWeight: FontWeight.normal,
                  fontSize: 100.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
