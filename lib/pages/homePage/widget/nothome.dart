import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/homePage/widget/add_button.dart';

import '../../../services/userdata.dart';

class NotHome extends StatelessWidget {
  NotHome({super.key});

  String firstName = UserData.instance.getFirstName()!;
  String lastName = UserData.instance.getLastName()!;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 400.h,
          ),
          Text(
            "Buongiorno!",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
              color: Theme.of(context).textTheme.displayLarge?.color,
              fontWeight: FontWeight.bold,
              fontSize: 130.sp,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            '$firstName $lastName',
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.displayMedium?.fontFamily,
              color: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.color!
                  .withOpacity(0.6),
              fontWeight: FontWeight.bold,
              fontSize: 65.sp,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 800.h,
          ),
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
