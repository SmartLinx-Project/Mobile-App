import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartlinx/services/hive.dart';

class SmartTermostatPage extends StatefulWidget {
  final DeviceThermostat device;

  const SmartTermostatPage({super.key, required this.device});

  @override
  State<SmartTermostatPage> createState() => _SmartTermostatPageState();
}

class _SmartTermostatPageState extends State<SmartTermostatPage> {
  bool mode = false;
  String finalName = '';

  @override
  void initState() {
    super.initState();
    checkName();
  }

  void checkName() {
    String name = widget.device.name;
    List<String> splitName = name.split(' ');
    if (splitName.length > 2) {
      splitName.removeRange(1, splitName.length - 1);
    }
    for (int i = 0; i < splitName.length; i++) {
      splitName[i] = (splitName[i].length < 12)
          ? splitName[i]
          : '${splitName[i].substring(0, 12)}...';
    }
    if (splitName.length > 1) {
      for (int i = 0; i < splitName.length; i++) {
        finalName += splitName[i];
        if (i != splitName.length - 1) {
          finalName += '\n';
        }
      }
    } else {
      finalName = (widget.device.name.length < 12)
          ? widget.device.name
          : '${widget.device.name.substring(0, 12)}...';
    }
  }

  @override
  Widget build(BuildContext context) {
    String degrees = widget.device.temperature.toStringAsFixed(1);
    String humidity = widget.device.humidity.toStringAsFixed(0);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.only(top: 150.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 70.w),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
                color: Theme.of(context).iconTheme.color,
                iconSize: 90.sp,
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 120.w),
                  child: Text(
                    finalName,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge?.color,
                      fontFamily:
                          Theme.of(context).textTheme.displayLarge?.fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 110.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 120.w, top: 30.h),
                  child: Text(
                    finalName,
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.color
                          ?.withOpacity(0.2),
                      fontFamily:
                          Theme.of(context).textTheme.displayMedium?.fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 170.sp,
                      height: 3.5.h,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 300.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 1100.h,
                width: 1100.w,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.background,
                    ],
                    stops: const [0.0, 0.95],
                    radius: 0.5,
                    center: Alignment.center,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: (mode)
                            ? EdgeInsets.only(right: 20.w)
                            : EdgeInsets.only(right: 0.w),
                        child: Text(
                          (!mode) ? '$degrees°' : humidity.toString(),
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.fontFamily,
                            color: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.color!
                                .withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 250.sp,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      if (mode)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '%',
                              style: TextStyle(
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.fontFamily,
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.color!
                                    .withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                                fontSize: 100.sp,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 15,
                            )
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 300.h,
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    height: 10.h,
                    width: MediaQuery.of(context).size.width / 1.3,
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).iconTheme.color!.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  SizedBox(
                    height: 120.h,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            mode = false;
                          });
                        },
                        child: Container(
                          height: 300.h,
                          width: 300.w,
                          decoration: BoxDecoration(
                              color: (!mode)
                                  ? Theme.of(context).colorScheme.onSurface
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                width: 8.h,
                                color: (mode)
                                    ? Theme.of(context).colorScheme.onSurface
                                    : Colors.transparent,
                              )),
                          child: Center(
                              child: SvgPicture.asset(
                            'assets/svg/temperature.svg',
                            color: Theme.of(context)
                                .iconTheme
                                .color!
                                .withOpacity(0.8),
                            height: 150.h,
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 150.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            mode = true;
                          });
                        },
                        child: Container(
                          height: 300.h,
                          width: 300.w,
                          decoration: BoxDecoration(
                              color: (mode)
                                  ? Theme.of(context).colorScheme.onSurface
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                width: 8.h,
                                color: (!mode)
                                    ? Theme.of(context).colorScheme.onSurface
                                    : Colors.transparent,
                              )),
                          child: Center(
                              child: SvgPicture.asset(
                            'assets/svg/humidity.svg',
                            color: Theme.of(context)
                                .iconTheme
                                .color!
                                .withOpacity(0.8),
                            height: 150.h,
                          )),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
