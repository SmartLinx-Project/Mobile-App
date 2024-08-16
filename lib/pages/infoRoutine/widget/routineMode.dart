import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../services/hive.dart';
import '../../../services/http.dart';

class RoutineMode extends StatefulWidget {
  final Routine routine;
  const RoutineMode({super.key, required this.routine});

  @override
  State<RoutineMode> createState() => _RoutineModeState();
}

class _RoutineModeState extends State<RoutineMode> {
  String routineMode = '';
  late IconData icon;
  String periodicityString = '';
  String? time;

  void fillField() {
    Routine routine = widget.routine;
    if (routine.time != null) {
      routineMode = 'Esecuzione Automatica';
      icon = Icons.auto_awesome;
      if (routine.periodicity != null) {
        parsePeriodicity();
      }
    } else {
      routineMode = 'Esecuzione Manuale';
      icon = Icons.play_arrow_rounded;
      periodicityString = 'Per azionare la routine tocca il pulsante';
    }
    if (routine.time != null) {
      DateTime routineTime = widget.routine.time!;
      time = '';
      time = 'Ora: ${routineTime.hour}:${routineTime.minute}';
    }
  }

  void parsePeriodicity() {
    List<dynamic> periodicity = widget.routine.periodicity!;
    Map<String, String> week = {
      'monday': 'Lun',
      'tuesday': 'Mar',
      'wednesday': 'Mer',
      'thursday': 'Gio',
      'friday': 'Ven',
      'saturday': 'Sab',
      'sunday': 'Dom'
    };
    periodicityString = 'Giorni: ';
    for (int i = 0; i < periodicity.length; i++) {
      periodicityString += week[periodicity[i].toString()].toString();
      if (i != periodicity.length - 1) {
        periodicityString += ', ';
      }
    }
  }

  void changeStateValue(bool newValue) {
    setState(() {
      widget.routine.enabled = newValue;
      HttpService().setRoutine(routine: widget.routine);
    });
  }

  bool getStateValue() {
    return widget.routine.enabled;
  }

  @override
  Widget build(BuildContext context) {
    fillField();
    return Container(
      height: 310.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(100.r),
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.r),
        child: Row(
          children: [
            SizedBox(
              width: 20.w,
            ),
            Icon(
              icon,
              size: 100.sp,
            ),
            SizedBox(
              width: 90.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  routineMode,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.w500,
                    fontSize: 62.sp,
                  ),
                ),
                SizedBox(
                  height: 20.w,
                ),
                Text(
                  (periodicityString == '') ? 'Non ripetere' : periodicityString,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.normal,
                    fontSize: 43.sp,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 8.w,
                ),
                if (time != null)
                  Text(
                    time!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily:
                          Theme.of(context).textTheme.displayLarge?.fontFamily,
                      fontWeight: FontWeight.normal,
                      fontSize: 43.sp,
                    ),
                    textAlign: TextAlign.left,
                  ),
              ],
            ),
            SizedBox(
              width: 90.w,
            ),
            if (widget.routine.time != null)
              Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: getStateValue(),
                  onChanged: (newValue) {
                    changeStateValue(newValue);
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
