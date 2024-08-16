import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/devicePage/device_page.dart';
import 'package:smartlinx/pages/smartPlug/smartlight_logic.dart';
import 'package:smartlinx/pages/smartPlug/widget/cons_wid.dart';
import '../../services/hive.dart';

class SmartPlugPage extends StatefulWidget {
  final DevicePlug device;

  const SmartPlugPage({super.key, required this.device});

  @override
  State<SmartPlugPage> createState() => _SmartPlugPageState();
}

class _SmartPlugPageState extends State<SmartPlugPage> {
  late String imageAsset;
  bool isLoading = false;
  String finalName = '';

  @override
  void initState() {
    super.initState();
    checkName();
  }

  void setImage() {
    if (widget.device.enabled) {
      imageAsset = 'assets/images/plug_on.png';
    } else {
      imageAsset = 'assets/images/plug_off.png';
    }
  }

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

  void handlePlugState(bool newValue) async {
    showLoadingDialog();
    if (!widget.device.enabled) {
      if (await SmartPlugLogic().turnOnPlugDevice(widget.device)) {
        setState(() {
          widget.device.enabled = newValue;
        });
      }
    } else {
      if (await SmartPlugLogic().turnOffPlugDevice(widget.device)) {
        setState(() {
          widget.device.enabled = newValue;
        });
      }
    }
    hideLoadingDialog();
  }

  void checkName() {
    String name = widget.device.name;
    List<String> splitName = name.split(' ');
    if (splitName.length > 2) {
      splitName.removeRange(1, splitName.length - 1);
    }
    for (int i = 0; i < splitName.length; i++) {
      splitName[i] = (splitName[i].length < 11)
          ? splitName[i]
          : '${splitName[i].substring(0, 11)}...';
    }
    if (splitName.length > 1) {
      for (int i = 0; i < splitName.length; i++) {
        finalName += splitName[i];
        if (i != splitName.length - 1) {
          finalName += '\n';
        }
      }
    } else {
      finalName = (widget.device.name.length < 10)
          ? widget.device.name
          : '${widget.device.name.substring(0, 10)}...';
    }
  }

  @override
  Widget build(BuildContext context) {
    setImage();
    return PopScope(
      onPopInvoked: (value) {
        Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  const DevicePage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
            (route) => false);
      },
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 150.h, left: 70.w),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              const DevicePage(),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.arrow_back_ios_new),
                                color: Theme.of(context).iconTheme.color,
                                iconSize: 90.sp,
                              ),
                            ),
                            SizedBox(
                              height: 180.h,
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 120.w),
                                  child: Text(
                                    finalName,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.color,
                                      fontFamily: Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.fontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 110.sp,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 120.w, top: 30.h),
                                  child: Text(
                                    finalName,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.color
                                          ?.withOpacity(0.2),
                                      fontFamily: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.fontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 170.sp,
                                      height: 3.5.h,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 200.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 120.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Stato',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.color,
                                      fontFamily: Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.fontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 70.sp,
                                    ),
                                  ),
                                  Transform.scale(
                                    scaleX: 0.8,
                                    scaleY: 0.7,
                                    child: Switch(
                                      value: widget.device.enabled,
                                      onChanged: (newValue) {
                                        handlePlugState(newValue);
                                      },
                                      trackOutlineColor:
                                          MaterialStateProperty.resolveWith(
                                        (final Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return null;
                                          }

                                          return Colors.transparent;
                                        },
                                      ),
                                      inactiveTrackColor:
                                          const Color(0xFFc4c4c4),
                                      inactiveThumbColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 3,
                              top: MediaQuery.of(context).size.height / 4.5),
                          child: Column(
                            children: [
                              Image.asset(
                                imageAsset,
                                height: 1000.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 300.h,
                ),
                ConsumptionWidget(
                  device: widget.device,
                ),
              ],
            ),
            /*
            SlidingUpPanel(
              minHeight: 350.h,
              maxHeight: 2500.h,
              color: Colors.transparent,
              slideDirection: SlideDirection.UP,
              panel: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(150.r),
                      topLeft: Radius.circular(150.r)),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                child: SmartPlugBodyPopup(
                  device: widget.device,
                ),
              ),
            ),
            */
          ],
        ),
      ),
    );
  }
}
