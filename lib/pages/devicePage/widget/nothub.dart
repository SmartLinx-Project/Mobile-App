import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'addHubPopup/addhub_button.dart';

class NotHub extends StatelessWidget {
  int homeID;
  Function refreshPage;
  NotHub({super.key, required this.homeID, required this.refreshPage});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 130.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(

            height: MediaQuery.of(context).size.height/4,
          ),
          Center(
            child: Text(
              "Per iniziare ad aggiungere dispositivi alla tua casa configura un Hub",
              style: TextStyle(
                fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
                color: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.color!
                    .withOpacity(0.7),
                fontWeight: FontWeight.normal,
                fontSize: 75.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 100.h,
          ),
          AddHubButton(homeID: homeID, refreshPage: refreshPage,),
        ],
      ),
    );
  }
}
