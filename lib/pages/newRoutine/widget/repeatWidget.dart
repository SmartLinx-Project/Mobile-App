import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/newRoutine/widget/dayWid.dart';

import '../../../services/hive.dart';

class RoutineRepeatWidget extends StatefulWidget {
  final Function updatePeriodicity;
  final Routine? previousRoutine;
  const RoutineRepeatWidget(
      {super.key, required this.updatePeriodicity, this.previousRoutine});

  @override
  State<RoutineRepeatWidget> createState() => _RoutineRepeatWidgetState();
}

class _RoutineRepeatWidgetState extends State<RoutineRepeatWidget> {
  List<RoutineDayObject> periodicity = [];
  String labelText = '';
  bool allDayRepeat = true;
  Map<String, String> labelMap = {
    'monday': 'Lun',
    'tuesday': 'Mar',
    'wednesday': 'Mer',
    'thursday': 'Gio',
    'friday': 'Ven',
    'saturday': 'Sab',
    'sunday': 'Dom',
  };

  void initPeriodicity() {
    List<String> dayOfWeek = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday'
    ];
    for (int i = 0; i < 7; i++) {
      RoutineDayObject day = RoutineDayObject();
      day.name = dayOfWeek[i];
      periodicity.add(day);
    }
  }

  void addDay(String day) {
    int index = periodicity.indexWhere((obj) => obj.name == day);
    if (index != -1) {
      periodicity[index].isSelected = true;
      setState(() {});
    }
  }

  void removeDay(String day) {
    int index = periodicity.indexWhere((obj) => obj.name == day);
    if (index != -1) {
      periodicity[index].isSelected = false;
      setState(() {});
    }
  }

  bool checkSelected(String day) {
    int index = periodicity.indexWhere((obj) => obj.name == day);
    if (index != -1) {
      return periodicity[index].isSelected;
    }
    return false;
  }

  void composeLabel() {
    List<String> selectedLabel = [];
    for (int i = 0; i < periodicity.length; i++) {
      if (periodicity[i].isSelected) {
        selectedLabel.add(labelMap[periodicity[i].name].toString());
      }
    }
    if (selectedLabel.isEmpty) {
      labelText = 'Una volta';
      allDayRepeat = false;
    } else if (selectedLabel.length == 7) {
      labelText = 'Ogni giorno';
      allDayRepeat = true;
    } else {
      labelText = '';
      for (int i = 0; i < selectedLabel.length; i++) {
        labelText = labelText + selectedLabel[i];
        if (i != selectedLabel.length - 1) {
          labelText = '$labelText, ';
        }
      }
      allDayRepeat = false;
    }
  }

  void selectAllDays() {
    if (!allDayRepeat) {
      for (int i = 0; i < periodicity.length; i++) {
        periodicity[i].isSelected = true;
      }
      setState(() {
        allDayRepeat = true;
      });
    } else {
      for (int i = 0; i < periodicity.length; i++) {
        periodicity[i].isSelected = false;
      }
      setState(() {
        allDayRepeat = false;
      });
    }
  }

  void checkPreviousRoutine() {
    if (widget.previousRoutine?.periodicity == null) {
      return;
    }
    List<dynamic> week = widget.previousRoutine!.periodicity!;
    for (dynamic day in week) {
      for (int i = 0; i < periodicity.length; i++) {
        if (day.toString() == periodicity[i].name) {
          periodicity[i].isSelected = true;
        }
      }
    }
  }

  @override
  void initState() {
    initPeriodicity();
    checkPreviousRoutine();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    composeLabel();
    widget.updatePeriodicity(periodicity);
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70.r),
        color: Theme.of(context).colorScheme.onSurface,
      ),
      child: Padding(
        padding: EdgeInsets.all(80.w),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Ripeti',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.w500,
                    fontSize: 75.sp,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  width: 40.h,
                ),
                Text(
                  labelText,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.w500,
                    fontSize: 68.sp,
                  ),
                  textAlign: TextAlign.left,
                ),
                const Spacer(),
              ],
            ),
            SizedBox(
              height: 115.h,
            ),
            Row(
              children: [
                RoutineDayWidget(
                  day: 'monday',
                  visualizedDay: 'L',
                  addDay: addDay,
                  removeDay: removeDay,
                  checkSelected: checkSelected,
                ),
                const Spacer(),
                RoutineDayWidget(
                  day: 'tuesday',
                  visualizedDay: 'M',
                  addDay: addDay,
                  removeDay: removeDay,
                  checkSelected: checkSelected,
                ),
                const Spacer(),
                RoutineDayWidget(
                  day: 'wednesday',
                  visualizedDay: 'M',
                  addDay: addDay,
                  removeDay: removeDay,
                  checkSelected: checkSelected,
                ),
                const Spacer(),
                RoutineDayWidget(
                  day: 'thursday',
                  visualizedDay: 'G',
                  addDay: addDay,
                  removeDay: removeDay,
                  checkSelected: checkSelected,
                ),
                const Spacer(),
                RoutineDayWidget(
                  day: 'friday',
                  visualizedDay: 'V',
                  addDay: addDay,
                  removeDay: removeDay,
                  checkSelected: checkSelected,
                ),
                const Spacer(),
                RoutineDayWidget(
                  day: 'saturday',
                  visualizedDay: 'S',
                  addDay: addDay,
                  removeDay: removeDay,
                  checkSelected: checkSelected,
                ),
                const Spacer(),
                RoutineDayWidget(
                  day: 'sunday',
                  visualizedDay: 'D',
                  addDay: addDay,
                  removeDay: removeDay,
                  checkSelected: checkSelected,
                ),
              ],
            ),
            SizedBox(
              height: 90.h,
            ),
            Row(
              children: [
                Text(
                  'Ripeti ogni giorno',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.normal,
                    fontSize: 64.sp,
                  ),
                  textAlign: TextAlign.left,
                ),
                const Spacer(),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                      value: allDayRepeat,
                      onChanged: (newValue) {
                        selectAllDays();
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RoutineDayObject {
  String _name = '';
  bool _isSelected = false;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }
}
