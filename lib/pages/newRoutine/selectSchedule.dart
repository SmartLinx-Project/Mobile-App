import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/newRoutine/customRoutine.dart';
import 'package:smartlinx/pages/newRoutine/selDevicePage.dart';
import 'package:smartlinx/pages/newRoutine/widget/repeatWidget.dart';
import 'package:smartlinx/pages/newRoutine/widget/timePicker.dart';
import '../../services/hive.dart';

class SelectRoutineSchedule extends StatefulWidget {
  final List<RoutineObject> devices;
  final Routine? previousRoutine;
  const SelectRoutineSchedule(
      {super.key, required this.devices, this.previousRoutine});

  @override
  State<SelectRoutineSchedule> createState() => _SelectRoutineScheduleState();
}

class _SelectRoutineScheduleState extends State<SelectRoutineSchedule> {
  bool isScheduled = true;
  DateTime time = DateTime.now();
  List<RoutineDayObject> periodicity = [];

  void updateTime(DateTime newTime) {
    time = newTime;
  }

  void updatePeriodicity(List<RoutineDayObject> update) {
    periodicity = update;
  }

  List<String> getDaysString() {
    List<String> days = [];
    for (int i = 0; i < periodicity.length; i++) {
      if (periodicity[i].isSelected) {
        days.add(periodicity[i].name);
        print(periodicity[i].name);
      }
    }
    return days;
  }

  void checkPreviousRoutine() {
    if (widget.previousRoutine == null) {
      return;
    }
    if(widget.previousRoutine?.time != null){
      time = widget.previousRoutine!.time!;
    };
  }

  @override
  void initState() {
    checkPreviousRoutine();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).textTheme.displayLarge?.color,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Schedulazione',
          style: TextStyle(
            color: Theme.of(context).textTheme.displayLarge?.color,
            fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
            fontWeight: FontWeight.normal,
            fontSize: 70.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60.w),
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
            ),
            RoutineTimePicker(
              initialTime: time,
              updateTime: updateTime,
            ),
            SizedBox(
              height: 100.h,
            ),
            RoutineRepeatWidget(
              updatePeriodicity: updatePeriodicity,
              previousRoutine: widget.previousRoutine,
            ),
            const Spacer(),
            Container(
              width: 850.w,
              height: 180.h,
              decoration: BoxDecoration(
                color: (isScheduled)
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withOpacity(0.6),
                borderRadius: BorderRadius.circular(150.r),
              ),
              child: TextButton(
                onPressed: () async {
                  if (isScheduled) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            CustomRoutinePage(
                          routines: widget.devices,
                          days: getDaysString(),
                          time: time,
                          previousRoutine: (widget.previousRoutine != null)
                              ? widget.previousRoutine
                              : null,
                        ),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  }
                },
                child: Text(
                  'Successivo',
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 68.sp,
                    color: (isScheduled)
                        ? Colors.white
                        : Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
          ],
        ),
      ),
    );
  }
}
