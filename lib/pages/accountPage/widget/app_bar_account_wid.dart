import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/services/auth.dart';
import 'package:smartlinx/pages/selectLogin/selectlogin_page.dart';

class AppBarAccountInfo extends StatelessWidget {
  const AppBarAccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Account"),
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
        color: Theme.of(context).textTheme.displayLarge?.color,
        fontWeight: FontWeight.normal,
        fontSize: 70.sp,
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.exit_to_app, size: 95.sp,),
          onPressed: () {
            Auth().signOut();
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                const SelectLoginPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          },
        ),
      ],
    );
  }
}
