import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/newRoutine/customRoutine.dart';
import 'package:smartlinx/pages/newRoutine/selDevicePage.dart';
import 'package:smartlinx/pages/newRoutine/selectSchedule.dart';
import 'package:smartlinx/pages/newRoutine/widget/routineModeWid.dart';

import '../../services/hive.dart';

class SelectRoutineMode extends StatefulWidget {
  final List<RoutineObject> devices;
  final Routine? previousRoutine;
  const SelectRoutineMode(
      {super.key, required this.devices, this.previousRoutine});

  @override
  State<SelectRoutineMode> createState() => _SelectRoutineModeState();
}

class _SelectRoutineModeState extends State<SelectRoutineMode>
    with SingleTickerProviderStateMixin {
  late AnimationController iconController;

  int? currentMode;

  @override
  void initState() {
    super.initState();
    checkPreviousRoutine();
    iconController = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 1), // Specify a duration for the animation
    );
  }

  void checkPreviousRoutine() {
    if (widget.previousRoutine == null) {
      return;
    }
    if (widget.previousRoutine!.time == null) {
      currentMode = 0;
    } else {
      currentMode = 1;
    }
  }

  int? getCurrentMode() {
    return currentMode;
  }

  void setCurrentMode(int selectedType) {
    if (selectedType == currentMode) {
      setState(() {
        currentMode = null;
      });
    } else {
      setState(() {
        currentMode = selectedType;
      });
    }
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
          'Modalità Routine',
          style: TextStyle(
            color: Theme.of(context).textTheme.displayLarge?.color,
            fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
            fontWeight: FontWeight.normal,
            fontSize: 70.sp,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 13,
          ),
          RoutineModeWidget(
            type: 0,
            getCurrentMode: getCurrentMode,
            setCurrentMode: setCurrentMode,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          RoutineModeWidget(
            type: 1,
            getCurrentMode: getCurrentMode,
            setCurrentMode: setCurrentMode,
          ),
          const Spacer(),
          Container(
            width: 850.w,
            height: 180.h,
            decoration: BoxDecoration(
              color: (currentMode != null)
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.6),
              borderRadius: BorderRadius.circular(150.r),
            ),
            child: TextButton(
              onPressed: () async {
                if (currentMode != null) {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          (currentMode == 0)
                              ? CustomRoutinePage(
                                  routines: widget.devices,
                                  previousRoutine: widget.previousRoutine,
                                )
                              : SelectRoutineSchedule(
                                  devices: widget.devices,
                                  previousRoutine: widget.previousRoutine,
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
                  color: (currentMode != null)
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
    );
  }

  @override
  void dispose() {
    iconController.dispose();
    super.dispose();
  }
}
