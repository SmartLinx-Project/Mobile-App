import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/hive.dart';
import '../../../services/hiveMethod/home_hive.dart';

class NotRoutinesWidget extends StatelessWidget {
  const NotRoutinesWidget({super.key});

  bool checkIfHaveHome() {
    List<Home> homes = HomeHive.instance.getAllHomes();
    if (homes.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (checkIfHaveHome())
                ? 'Non hai routine in questa casa!'
                : 'Non possiedi una casa!',
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.color!
                  .withOpacity(0.8),
              fontFamily: Theme.of(context).textTheme.displayMedium?.fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 65.sp,
            ),
          ),
          SizedBox(
            height: 100.h,
          ),
          Icon(
            (checkIfHaveHome()) ? Icons.auto_awesome : Icons.home,
            size: 130.w,
            color: Theme.of(context)
                .textTheme
                .displayMedium
                ?.color!
                .withOpacity(0.8),
          ),
        ],
      ),
    );
  }
}
