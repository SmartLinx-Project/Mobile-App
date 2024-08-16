import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/homePage/widget/add_button.dart';

class NotHome extends StatelessWidget {
  const NotHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Non hai ancora una casa!",
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
                color: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.color!
                    .withOpacity(0.7),
                fontWeight: FontWeight.normal,
                fontSize: 80.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 100.h,
          ),
          const Center(
            child: AddButton(),
          )
        ],
      ),
    );
  }
}
