import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/smartlLight/widget/repeat_wid.dart';
import 'package:smartlinx/services/hive.dart';
import 'package:smartlinx/services/http.dart';

import '../../../services/hiveMethod/device_plug_hive.dart';

class ScheduleBodyPlugWidget extends StatefulWidget {
  final DevicePlug device;
  const ScheduleBodyPlugWidget({
    super.key,
    required this.device,
  });

  @override
  State<ScheduleBodyPlugWidget> createState() =>
      _ScheduleBodyPlugWidgetState();
}

class _ScheduleBodyPlugWidgetState extends State<ScheduleBodyPlugWidget> {
  bool isRepeated = false;
  late String startTime;
  late String endTime;
  List<String> periodicity = [];
  List<dayofWeek> week = [];
  late int deviceID;

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }

  void hideLoadingDialog() {
    Navigator.of(context).pop();
  }

  void initSchedule() {
    periodicity = [];
    deviceID = widget.device.deviceID;
    DevicePlug device = DevicePlugHive.instance.getDevicesFromID(deviceID);
    startTime = device.startTime;
    endTime = device.endTime;
    List<dynamic> listPeriodicity =
        DevicePlugHive.instance.getDevicesFromID(deviceID).periodicity;
    String day;
    for (day in listPeriodicity) {
      if (day.isNotEmpty) {
        periodicity.add(day);
      }
    }
    if (periodicity.isNotEmpty) {
      isRepeated = true;
    }
  }

  Time getStartTime() {
    List<String> sTime = startTime.split(':');
    return Time(hour: int.parse(sTime[0]), minute: int.parse(sTime[1]));
  }

  Time getEndTime() {
    List<String> eTime = endTime.split(':');
    return Time(hour: int.parse(eTime[0]), minute: int.parse(eTime[1]));
  }

  void setStartTime(Time sTime) {
    String hour = sTime.hour.toString();
    String minute = sTime.minute.toString();
    if (hour.length == 1) {
      hour = '0$hour';
    }
    if (minute.length == 1) {
      minute = '0$minute';
    }
    startTime = '$hour:$minute:00';
  }

  void setEndTime(Time eTime) {
    String hour = eTime.hour.toString();
    String minute = eTime.minute.toString();
    if (hour.length == 1) {
      hour = '0$hour';
    }
    if (minute.length == 1) {
      minute = '0$minute';
    }
    endTime = '$hour:$minute:00';
  }

  void deleteRepetition() {
    periodicity = [];
    week.clear();
    setState(() {
      isRepeated = false;
    });
  }

  void saveChanges() async {
    List<dynamic> newPeriodicity = periodicity as dynamic;
    periodicity.clear();
    for (int i = 0; i < week.length; i++) {
      if (week[i].isSelected) {
        periodicity.add(week[i].name);
      }
    }
    showLoadingDialog();
    if (await HttpService().setDevice(
        deviceID: deviceID,
        name: widget.device.name,
        schedState: true,
        startTime: startTime,
        endTime: endTime,
        periodicity: periodicity)) {
      DevicePlugHive.instance.setStartTime(deviceID, startTime);
      DevicePlugHive.instance.setEndTime(deviceID, endTime);
      DevicePlugHive.instance.setPeriodicity(deviceID, newPeriodicity);
      DevicePlugHive.instance.setSchedState(deviceID, true);
    }
    hideLoadingDialog();
  }

  void tempPeriodicityKeep() {
    dayofWeek day;
    periodicity.clear();
    for (day in week) {
      if (day.isSelected) {
        periodicity.add(day.name);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ripetizione',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    fontFamily:
                    Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 80.sp,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Scegli i giorni in a cui vuoi applicare\nla routine',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayMedium?.color,
                    fontFamily:
                    Theme.of(context).textTheme.displayMedium?.fontFamily,
                    fontWeight: FontWeight.normal,
                    fontSize: 45.sp,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            const Spacer(),
            Transform.scale(
              scaleX: 0.8,
              scaleY: 0.7,
              child: Switch(
                value: isRepeated,
                onChanged: (newValue) {
                  setState(() {
                    isRepeated = newValue;
                    if (!isRepeated) {
                      deleteRepetition();
                    }
                  });
                },
                trackOutlineColor: MaterialStateProperty.resolveWith(
                      (final Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return null;
                    }

                    return Colors.transparent;
                  },
                ),
                inactiveTrackColor: const Color(0xFFc4c4c4),
                inactiveThumbColor: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 90.h,
        ),
        if (isRepeated)
          RepeatWidget(
            periodicity: periodicity,
            week: week,
          ),
        Container(
          height: 7.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).iconTheme.color!.withOpacity(0.1),
          ),
        ),
        SizedBox(
          height: 70.h,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Seleziona ora',
            style: TextStyle(
              color: Theme.of(context).textTheme.displayLarge?.color,
              fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 80.sp,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 35.h,
        ),
        Row(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Accensione',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.displayMedium?.color,
                      fontFamily:
                      Theme.of(context).textTheme.displayMedium?.fontFamily,
                      fontWeight: FontWeight.normal,
                      fontSize: 47.sp,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        showPicker(
                          hourLabel: 'Ora',
                          minuteLabel: 'Minuti',
                          secondLabel: 'Secondi',
                          is24HrFormat: true,
                          context: context,
                          value: getStartTime(),
                          sunrise:
                          const TimeOfDay(hour: 6, minute: 0), // optional
                          sunset:
                          const TimeOfDay(hour: 18, minute: 0), // optional
                          duskSpanInMinutes: 120, // optional
                          onChange: (newTime) {
                            setStartTime(newTime);
                            tempPeriodicityKeep();
                          },
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 140.w),
                      height: 150.h,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(40.r),
                          border: Border.all(
                              color: Theme.of(context)
                                  .iconTheme
                                  .color!
                                  .withOpacity(0.8),
                              width: 4.sp)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            '${startTime.split(':')[0]}:${startTime.split(':')[1]}',
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.fontFamily,
                              fontSize: 60.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.color,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 70.w,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Spegnimento',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.displayMedium?.color,
                      fontFamily:
                      Theme.of(context).textTheme.displayMedium?.fontFamily,
                      fontWeight: FontWeight.normal,
                      fontSize: 47.sp,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        showPicker(
                          hourLabel: 'Ora',
                          minuteLabel: 'Minuti',
                          secondLabel: 'Secondi',
                          is24HrFormat: true,
                          context: context,
                          value: getEndTime(),
                          sunrise:
                          const TimeOfDay(hour: 6, minute: 0), // optional
                          sunset:
                          const TimeOfDay(hour: 18, minute: 0), // optional
                          duskSpanInMinutes: 120, // optional
                          onChange: (newTime) {
                            setEndTime(newTime);
                            tempPeriodicityKeep();
                          },
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 140.w),
                      height: 150.h,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(40.r),
                          border: Border.all(
                              color: Theme.of(context)
                                  .iconTheme
                                  .color!
                                  .withOpacity(0.8),
                              width: 4.sp)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${endTime.split(':')[0]}:${endTime.split(':')[1]}',
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.fontFamily,
                            fontSize: 60.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.only(bottom: 120.h),
          child: Row(
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    week.clear();
                    initSchedule();
                    setState(() {});
                  },
                  child: Container(
                    height: 150.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(40.r),
                      border: Border.all(
                        color:
                        Theme.of(context).iconTheme.color!.withOpacity(0.8),
                        width: 5.w,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Cancella',
                        style: TextStyle(
                          fontFamily: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.fontFamily,
                          fontSize: 60.sp,
                          fontWeight: FontWeight.w500,
                          color:
                          Theme.of(context).textTheme.displayLarge?.color,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 70.w,
              ),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    saveChanges();
                  },
                  child: Container(
                    height: 150.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF464646),
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Conferma',
                        style: TextStyle(
                          fontFamily: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.fontFamily,
                          fontSize: 60.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
