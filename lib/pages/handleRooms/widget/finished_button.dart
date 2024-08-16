import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/devicePage/device_page.dart';

class FinishedButton extends StatefulWidget {
  @override
  final Key? key;

  const FinishedButton({this.key}) : super(key: key);

  @override
  State<FinishedButton> createState() => _FinishedButtonState();
}

class _FinishedButtonState extends State<FinishedButton> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.4;
    return Container(
      width: buttonWidth,
      height: 200.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(75.r),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
              const DevicePage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        child: Text(
          'Finito',
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 68.sp,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
