import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smartlinx/pages/accountPage/account_page.dart';
import 'package:smartlinx/pages/devicePage/device_page.dart';
import 'package:smartlinx/pages/favouriteDevice/favouritedevices_page.dart';
import 'package:smartlinx/pages/homePage/home_page.dart';
import 'package:smartlinx/pages/routineDevice/routine_page.dart';

class BotNavBarWidget extends StatefulWidget {
  final int? index;

  const BotNavBarWidget({super.key, this.index});

  @override
  State<BotNavBarWidget> createState() => _BotNavBarWidgetState();
}

class _BotNavBarWidgetState extends State<BotNavBarWidget> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.index!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: 60.h, right: 30.w, left: 60.w, top: 50.h),
      child: GNav(
          onTabChange: (selectedValue) async {
            switch (selectedValue) {
              case 0:
                if (_index != 0) {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const HomePage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                }
                break;
              case 1:
                if (_index != 1) {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const FavouriteDevicePage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                }
                break;
              case 2:
                if (_index != 2) {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const RoutinePage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                }
                break;
              case 3:
                if (_index != 3) {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                      const DevicePage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                }
                break;
              case 4:
                if (_index != 4) {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const AccountPage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                }
                break;
            }
          },
          textSize: 50.sp,
          selectedIndex: _index,
          rippleColor: Theme.of(context)
              .bottomNavigationBarTheme
              .selectedItemColor!
              .withOpacity(0.2),
          haptic: true,
          tabBorderRadius: 30,
          gap: 10,
          color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          activeColor: Theme.of(context)
              .bottomNavigationBarTheme
              .selectedItemColor!
              .withOpacity(1),
          iconSize: 95.sp,
          tabBackgroundColor: Theme.of(context)
              .bottomNavigationBarTheme
              .selectedItemColor!
              .withOpacity(0.5),
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 45.w),
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: 'Home',
            ),
            GButton(
              icon: Icons.star_outline_outlined,
              text: 'Preferiti',
            ),
            GButton(
              icon: Icons.auto_mode,
              text: 'Routine',
            ),
            GButton(
              icon: Icons.dashboard_outlined,
              text: 'Dispositivi',
            ),
            GButton(
              icon: Icons.person_outline_sharp,
              text: 'Account',
            )
          ]),
    );
  }
}
