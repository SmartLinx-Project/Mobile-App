import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/services/hiveMethod/device_plug_hive.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/hiveMethod/room_hive.dart';
import 'package:smartlinx/services/http.dart';

import '../../../services/hive.dart';

class ConsumptionWidget extends StatefulWidget {
  final DevicePlug device;
  const ConsumptionWidget({super.key, required this.device});

  @override
  State<ConsumptionWidget> createState() => _ConsumptionWidgetState();
}

class _ConsumptionWidgetState extends State<ConsumptionWidget> {
  int watt = 0;
  double kwh = 0.00;
  bool isMonitoring = true;

  void updateConsumption() async {
    int hubID = HomeHive.instance
        .getHomeFromID(
            RoomHive.instance.getRoomFromID(widget.device.roomID).homeID)
        .hubID;
    String ieeeAddress = widget.device.ieeeAddress;
    String type = 'switch';
    while (isMonitoring) {
      if (widget.device.enabled) {
        Map<String, dynamic> newData = await HttpService()
            .getStatus(ieeeAddress: ieeeAddress, hubID: hubID, type: type);
        DevicePlug newDevice = widget.device;
        if (newData.isNotEmpty) {
          newDevice.power = newData['power'] as int;
          newDevice.energy = double.parse(newData['current'].toString());
          newDevice.enabled =
              (newData['state'].toString() == 'ON') ? true : false;
          DevicePlugHive.instance.editDevice(newDevice);
          watt = newDevice.power;
          kwh = newDevice.energy;
        }
        if (isMonitoring) {
          setState(() {});
        }
      } else {
        setState(() {
          watt = 0;
          kwh = 0;
        });
      }
      await Future.delayed(const Duration(milliseconds: 2000));
    }
  }

  @override
  void initState() {
    super.initState();
    watt = widget.device.power;
    kwh = widget.device.energy;
    updateConsumption();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.centerLeft,
        height: 730.h,
        width: 1200.w,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
          borderRadius: BorderRadius.circular(60.r),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 100.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 100.h,
                ),
                Text(
                  'Monitoraggio',
                  style: TextStyle(
                    fontSize: 77.sp,
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge!.fontFamily,
                    color: Theme.of(context).textTheme.displayLarge!.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 130.h,
                  width: 130.w,
                  decoration: BoxDecoration(
                    color: Colors.white24.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(300),
                  ),
                  child: const Icon(
                    Icons.electric_bolt,
                    color: Colors.yellow,
                  ),
                ),
                SizedBox(
                  width: 140.h,
                ),
              ],
            ),
            SizedBox(
              height: 100.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Potenza',
                        style: TextStyle(
                          fontSize: 70.sp,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .fontFamily,
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Row(
                        children: [
                          AnimatedDigitWidget(
                            value: watt,
                            textStyle: TextStyle(
                              fontSize: 85.sp,
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .fontFamily,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 25.w,
                          ),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Text(
                                'W',
                                style: TextStyle(
                                  fontSize: 45.sp,
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .fontFamily,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                height: 100.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Corrente',
                        style: TextStyle(
                          fontSize: 70.sp,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .fontFamily,
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Row(
                        children: [
                          AnimatedDigitWidget(
                            fractionDigits: 2,
                            value: kwh,
                            textStyle: TextStyle(
                              fontSize: 85.sp,
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .fontFamily,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 25.w,
                          ),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Text(
                                'A',
                                style: TextStyle(
                                  fontSize: 45.sp,
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .fontFamily,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                height: 80.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    isMonitoring = false;
    super.dispose();
  }
}
