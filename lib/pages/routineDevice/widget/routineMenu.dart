import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/newRoutine/selDevicePage.dart';
import 'package:smartlinx/services/hiveMethod/routine_hive.dart';
import 'package:smartlinx/services/http.dart';

class RoutineMenu extends StatelessWidget {
  final int routineID;
  final Function refreshPage;
  const RoutineMenu(
      {super.key, required this.routineID, required this.refreshPage});

  removeRoutine() async {
    if(await HttpService().delRoutine(routineID: routineID)){
      await RoutineHive.instance.removeRoutine(routineID);
      refreshPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 55.w,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      SelectDevicePage(
                    previousRoutine:
                        RoutineHive.instance.getRoutineFromID(routineID),
                  ),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit,
                  size: 80.sp,
                  color: Theme.of(context).iconTheme.color!.withOpacity(0.9),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Modifica',
                  style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .color!
                          .withOpacity(0.9),
                      fontSize: 40.sp),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            height: 140.h,
            width: 2,
            color: Theme.of(context).iconTheme.color!.withOpacity(0.4),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              removeRoutine();
              Navigator.pop(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete,
                  size: 80.sp,
                  color: Theme.of(context).iconTheme.color!.withOpacity(0.9),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Elimina',
                  style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .color!
                          .withOpacity(0.9),
                      fontSize: 40.sp),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 55.w,
          )
        ],
      ),
    );
  }
}
