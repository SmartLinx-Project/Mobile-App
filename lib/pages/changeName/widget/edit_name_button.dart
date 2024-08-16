import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditNameButton extends StatefulWidget {
  final VoidCallback onPressed;
  const EditNameButton({super.key, required this.onPressed});

  @override
  State<EditNameButton> createState() => _CambiaNomeButton();
}

class _CambiaNomeButton extends State<EditNameButton> {

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
              'Salva',
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
