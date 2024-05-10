import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popover/popover.dart';
import 'package:smartlinx/pages/smartTermostat/smarttermostat_page.dart';
import 'package:smartlinx/services/hive.dart';
import 'package:vibration/vibration.dart';

import '../menuItems/menu_bar.dart';

class DeviceThermostatWidget extends StatefulWidget {
  DeviceThermostat device;
  Function refreshPage;

  DeviceThermostatWidget(
      {super.key, required this.device, required this.refreshPage});

  @override
  State<DeviceThermostatWidget> createState() => _DeviceWidgetState();
}

class _DeviceWidgetState extends State<DeviceThermostatWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Vibration.vibrate(duration: 10);
        showPopover(
            context: context,
            radius: 35.sp,
            transitionDuration: const Duration(milliseconds: 100),
            width: 570.w,
            height: 250.h,
            bodyBuilder: (context) => MenuBarItems(
                deviceID: widget.device.deviceID,
                type: 2,
                refreshPage: widget.refreshPage),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            direction: PopoverDirection.top);
      },
      onTap: () {
        if (widget.device.isOnline) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  SmartTermostatPage(
                device: widget.device,
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(60.r),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 60.h, top: 30.h, left: 50.w),
          child: Column(
            children: [
              SizedBox(
                height: 25.h,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/thermo.svg',
                    color: Theme.of(context).iconTheme.color,
                    height: 110.h,
                  ),
                  const Spacer(),
                  if (!widget.device.isOnline)
                    Padding(
                      padding: EdgeInsets.only(right: 70.w),
                      child: Text(
                        'Offline',
                        style: TextStyle(
                          fontSize: 50.sp,
                          color:
                              Theme.of(context).textTheme.displayLarge?.color,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.fontFamily,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.only(right: 60.w),
                      child: Text(
                        '${widget.device.temperature.toStringAsFixed(0)}°',
                        style: TextStyle(
                          fontSize: 70.sp,
                          color:
                              Theme.of(context).textTheme.displayLarge?.color,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.fontFamily,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    (widget.device.name.length < 16) ? widget.device.name : '${widget.device.name.substring(0, 16)}...',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
