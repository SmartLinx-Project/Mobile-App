import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CambiaPasswordButton extends StatefulWidget {
  final VoidCallback onPressed;
  const CambiaPasswordButton({super.key, required this.onPressed});

  @override
  State<CambiaPasswordButton> createState() => _CambiaPasswordButton();
}

class _CambiaPasswordButton extends State<CambiaPasswordButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.w,
      height: 200.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(90.r),
      ),
      child: TextButton(
        onPressed: widget.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Cambia',
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 68.sp,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
