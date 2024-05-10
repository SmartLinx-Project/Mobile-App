import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/smartlLight/widget/repeat_wid.dart';
import 'package:smartlinx/pages/smartlLight/widget/schedulebody_wid.dart';
import 'package:smartlinx/services/hive.dart';
import 'package:smartlinx/services/hiveMethod/device_light_hive.dart';
import 'package:smartlinx/services/http.dart';

class SmartLightBodyPopup extends StatefulWidget {
  final DeviceLight device;
  const SmartLightBodyPopup({super.key, required this.device});

  @override
  State<SmartLightBodyPopup> createState() => _SmartLightBodyPopupState();
}

class _SmartLightBodyPopupState extends State<SmartLightBodyPopup> {
  bool scheduleState = false;
  List<dayofWeek> week = [];
  bool isLoading = false;

  void showLoadingDialog() {
    setState(() {
      isLoading = true;
    });
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
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
  }

  void saveChanges() async {
    int deviceID = widget.device.deviceID;
    DeviceLight device = DeviceLightHive.instance.getDevicesFromID(deviceID);
    List<dynamic> dynPeriodicity = device.periodicity;
    List<String> periodicity = [];
    String day;
    for (day in dynPeriodicity) {
      periodicity.add(day);
    }
    showLoadingDialog();
    if (await HttpService().setDevice(
        deviceID: device.deviceID,
        name: device.name,
        schedState: false,
        startTime: device.startTime,
        endTime: device.endTime,
        periodicity: periodicity)) {
      DeviceLightHive.instance
          .setSchedState(widget.device.deviceID, scheduleState);
    }
    hideLoadingDialog();
  }

  @override
  void initState() {
    super.initState();
    scheduleState = widget.device.schedState;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 90.h,
          ),
          Container(
            height: 15.h,
            width: 150.h,
            decoration: BoxDecoration(
              color: Theme.of(context).iconTheme.color!.withOpacity(0.7),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          SizedBox(
            height: 120.h,
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Programma',
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
                    'Attiva la programmazione per questo\ndispositivo',
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
                  value: scheduleState,
                  onChanged: (newValue) {
                    setState(() {
                      scheduleState = newValue;
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
            height: 70.h,
          ),
          Container(
            height: 7.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).iconTheme.color!.withOpacity(0.1),
            ),
          ),
          SizedBox(
            height: 100.h,
          ),
          if (scheduleState)
            Expanded(
              child: ScheduleBodyLightWidget(
                device: widget.device,
              ),
            ),
          if (!scheduleState) const Spacer(),
          if (!scheduleState)
            Container(
              padding: EdgeInsets.only(bottom: 120.h),
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
    );
  }
}
