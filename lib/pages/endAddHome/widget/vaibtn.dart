import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/devicePage/device_page.dart';

class VaiBtn extends StatefulWidget {
  const VaiBtn({super.key});

  @override
  State<VaiBtn> createState() => _VaiBtnState();
}
class _VaiBtnState extends State<VaiBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.w,
      height: 200.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(150.r),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
              const DevicePage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
              (route) => false
          );
        },
        child: Text(
          'Ho finito',
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 65.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

