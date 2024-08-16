import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:popover/popover.dart';
import 'package:smartlinx/pages/infoRoutine/infoRoutine.dart';
import 'package:smartlinx/pages/routineDevice/widget/routineMenu.dart';
import 'package:smartlinx/services/hive.dart';
import 'package:smartlinx/services/hiveMethod/device_light_hive.dart';
import 'package:smartlinx/services/http.dart';
import 'package:vibration/vibration.dart';
import '../../../services/hiveMethod/device_plug_hive.dart';
import '../../newRoutine/selDevicePage.dart';
import '../../smartPlug/smartlight_logic.dart';
import '../../smartlLight/smartlight_logic.dart';

class RoutineRectWid extends StatefulWidget {
  Routine routine;
  Function refreshPage;

  RoutineRectWid({super.key, required this.routine, required this.refreshPage});

  @override
  State<RoutineRectWid> createState() => _RoutineRectWidState();
}

class _RoutineRectWidState extends State<RoutineRectWid> {
  bool isLoading = false;
  late Routine routine;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> handleLightState(int deviceID, bool state) async {
    DeviceLight device = DeviceLightHive.instance.getDevicesFromID(deviceID);
    if (state) {
      if (await SmartLightLogic().turnOnLightDevice(device)) {
        setState(() {
          device.enabled = true;
        });
      }
    } else {
      if (await SmartLightLogic().turnOffLightDevice(device)) {
        setState(() {
          device.enabled = false;
        });
      }
    }
  }

  Future<void> handlePlugState(int deviceID, bool state) async {
    DevicePlug device = DevicePlugHive.instance.getDevicesFromID(deviceID);
    if (state) {
      if (await SmartPlugLogic().turnOnPlugDevice(device)) {
        setState(() {
          device.enabled = true;
        });
      }
    } else {
      if (await SmartPlugLogic().turnOffPlugDevice(device)) {
        setState(() {
          device.enabled = false;
        });
      }
    }
  }

  void runRoutine() async {
    setState(() {
      isLoading = true;
    });
    await HttpService().runRoutine(routine: routine);
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      isLoading = false;
      isChecked = true;
    });
    await Future.delayed(const Duration(milliseconds: 1800));
    setState(() {
      isChecked = false;
    });
  }

  bool isScheduled() {
    if (widget.routine.time != null) {
      return true;
    } else {
      return false;
    }
  }

  bool isEnabled() {
    return widget.routine.enabled;
  }

  void changeEnableValue(bool newValue) {
    setState(() {
      widget.routine.enabled = newValue;
      HttpService().setRoutine(routine: routine);
    });
  }

  @override
  Widget build(BuildContext context) {
    routine = widget.routine;
    return GestureDetector(
      onTap: () {
        //TODO: Da sostiuire con pagina gestione routine
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                RoutineInfoPage(routine: routine),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      onLongPress: () {
        Vibration.vibrate(duration: 10);
        showPopover(
            context: context,
            radius: 35.sp,
            transitionDuration: const Duration(milliseconds: 100),
            width: 570.w,
            height: 250.h,
            bodyBuilder: (context) => RoutineMenu(
                routineID: routine.routineID, refreshPage: widget.refreshPage),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            direction: PopoverDirection.top);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(60.r),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: 60.h, top: 30.h, left: 50.w, right: 50.w),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/routine_icon/${widget.routine.icon}.svg',
                    height: 110.h,
                  ),
                  const Spacer(),
                  (isScheduled())
                      ? Transform.scale(
                          scale: 0.7,
                          child: Switch(
                            value: isEnabled(),
                            onChanged: (newValue) {
                              changeEnableValue(newValue);
                            },
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            if (!isLoading && !isChecked) {
                              runRoutine();
                            }
                          },
                          child: Container(
                              height: 150.h,
                              width: 150.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.r),
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant
                                    .withOpacity(0.7),
                              ),
                              child: Stack(
                                children: [
                                  if (isLoading)
                                    Center(
                                      child: SizedBox(
                                        height: 150.h,
                                        width: 150.h,
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                        ),
                                      ),
                                    ),
                                  if (!isChecked)
                                    Center(
                                      child: Icon(
                                        Icons.play_arrow_rounded,
                                        size: 95.sp,
                                        color: Theme.of(context)
                                            .iconTheme
                                            .color!
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                  if (!isLoading && isChecked)
                                    Center(
                                      child: MSHCheckbox(
                                          size: 50,
                                          value: isChecked,
                                          style: MSHCheckboxStyle.fillScaleColor,
                                          colorConfig: MSHColorConfig
                                              .fromCheckedUncheckedDisabled(
                                            checkedColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            uncheckedColor: Colors.transparent,
                                          ),
                                          onChanged: (selected) {}),
                                    ),
                                ],
                              )),
                        ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    (widget.routine.name.length < 16)
                        ? widget.routine.name
                        : '${widget.routine.name.substring(0, 16)}...',
                    style: TextStyle(
                      fontSize: 50.sp,
                      color: Theme.of(context).textTheme.displayLarge?.color,
                      fontFamily:
                          Theme.of(context).textTheme.displayLarge?.fontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
