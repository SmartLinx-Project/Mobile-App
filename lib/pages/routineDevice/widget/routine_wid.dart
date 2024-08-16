import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/routineDevice/widget/notroutine_wid.dart';
import 'package:smartlinx/pages/routineDevice/widget/routine_rectwid.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/hiveMethod/routine_hive.dart';
import '../../../services/hive.dart';

class HaveRoutinesWidget extends StatefulWidget {
  final Function refreshPage;

  const HaveRoutinesWidget({super.key, required this.refreshPage});

  @override
  State<HaveRoutinesWidget> createState() => _HaveRoutinesWidgetState();
}

class _HaveRoutinesWidgetState extends State<HaveRoutinesWidget> {
  late List<Widget> routinsWidget = [];

  void fillRoutines() {
    List<Routine> routines = RoutineHive.instance.getAllRoutines();
    routinsWidget.clear();
    int? currentHome = HomeHive.instance.getCurrentHome();
    for (int i = 0; i < routines.length; i++) {
      if (currentHome == routines[i].homeID) {
        routinsWidget.add(
          RoutineRectWid(
            routine: routines[i],
            refreshPage: widget.refreshPage,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    fillRoutines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fillRoutines();
    return (routinsWidget.isNotEmpty)
        ? GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 700.h,
                crossAxisSpacing: 50.h,
                mainAxisSpacing: 50.h,
                mainAxisExtent: 375.h),
            itemCount: routinsWidget.length,
            itemBuilder: (context, index) {
              return routinsWidget[index];
            },
          )
        : const NotRoutinesWidget();
  }
}
