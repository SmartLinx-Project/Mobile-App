import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartlinx/pages/newRoutine/selDevicePage.dart';

class RoutineDeviceDialog extends StatefulWidget {
  final String deviceName;
  final int deviceType;
  final int deviceID;
  final Function addRoutine;
  final Function removeRoutine;
  final bool initialState;
  final bool initialSelected;
  const RoutineDeviceDialog(
      {super.key,
      required this.deviceName,
      required this.deviceType,
      required this.deviceID,
      required this.addRoutine,
      required this.removeRoutine,
      required this.initialState,
      required this.initialSelected});

  @override
  State<RoutineDeviceDialog> createState() => _RoutineDeviceDialogState();
}

class _RoutineDeviceDialogState extends State<RoutineDeviceDialog> {
  bool isSelected = false;
  bool state = false;
  late double unselectedHeight;
  late double selectedHeight;

  void updateState() {
    RoutineObject routine = RoutineObject();
    routine.deviceID = widget.deviceID;
    routine.action = state;

    setState(() {
      isSelected = !isSelected;
      if (isSelected) {
        widget.addRoutine(routine);
      } else {
        widget.removeRoutine(routine);
      }
    });
  }

  void updateSwitch() {
    RoutineObject routine = RoutineObject();
    routine.deviceID = widget.deviceID;
    routine.action = state;

    setState(() {
      widget.removeRoutine(routine);
      widget.addRoutine(routine);
    });
  }

  @override
  void initState() {
    isSelected = widget.initialSelected;
    state = widget.initialState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    unselectedHeight = 220.h;
    selectedHeight = 450.h;
    return GestureDetector(
      onTap: () {
        updateState();
      },
      child: Container(
        alignment: Alignment.center,
        height: (isSelected) ? selectedHeight : unselectedHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          color: (isSelected)
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(60.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 15,
                ),
                SvgPicture.asset(
                  (widget.deviceType == 0)
                      ? 'assets/svg/light.svg'
                      : 'assets/svg/plug.svg',
                  color: Theme.of(context).iconTheme.color,
                  height: 90.sp,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 10,
                ),
                Text(
                  (widget.deviceName.length < 20)
                      ? widget.deviceName
                      : '${widget.deviceName.substring(0, 17)} ...',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.sp,
                  ),
                ),
                const Spacer(),
                Center(
                  child: Transform.scale(
                    scale: 1.5,
                    child: ClipOval(
                      child: Checkbox(
                        value: isSelected,
                        onChanged: (newValue) {
                          updateState();
                        },
                        shape: const CircleBorder(),
                        side: BorderSide(
                            color: Theme.of(context).iconTheme.color!,
                            width: 1.2),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 15,
                ),
              ],
            ),
            if (isSelected)
              Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 15,
                      ),
                      Icon(
                        Icons.power_settings_new,
                        size: 90.sp,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 10,
                      ),
                      Text(
                        'Stato',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.displayLarge?.color,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 50.sp,
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            value: state,
                            onChanged: (newValue) {
                              setState(() {
                                state = newValue;
                                updateSwitch();
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 20,
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
