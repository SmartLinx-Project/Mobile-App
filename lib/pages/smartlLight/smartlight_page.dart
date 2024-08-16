import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/devicePage/device_page.dart';
import 'package:smartlinx/pages/smartlLight/smartlight_logic.dart';
import 'package:smartlinx/services/hive.dart';

class SmartLightPage extends StatefulWidget {
  final DeviceLight device;
  const SmartLightPage({super.key, required this.device});

  @override
  State<SmartLightPage> createState() => _SmartLightPageState();
}

class _SmartLightPageState extends State<SmartLightPage>
    with SingleTickerProviderStateMixin {
  late DeviceLight device;
  late bool isCold;
  late AnimationController lightController;
  late double intensityValue;
  bool isLoading = false;
  double startScroll = 0;
  String finalName = '';

  @override
  void initState() {
    super.initState();
    lightController = AnimationController(vsync: this);
    loadDeviceValue();
    intensityValue = device.brightness / 250;
    checkName();
  }

  void loadDeviceValue() {
    device = widget.device;
    if (device.colorTemp < 300) {
      isCold = true;
    } else {
      isCold = false;
    }
  }

  Future<void> reverseAnimation() async {
    await lightController.reverse();
    setState(() {});
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

  void handleLightState(bool newValue) async {
    showLoadingDialog();
    if (!device.enabled) {
      if (await SmartLightLogic().turnOnLightDevice(device)) {
        device.enabled = newValue;
      }
    } else {
      if (await SmartLightLogic().turnOffLightDevice(device)) {
        device.enabled = newValue;
      }
    }
    hideLoadingDialog();
    //reverseAnimation();
  }

  void handleLightTemp(bool newValue) async {
    if (newValue && !isCold) {
      showLoadingDialog();
      if (await SmartLightLogic().setColdLightDevice(device)) {
        setState(() {
          device.colorTemp = 250;
        });
        //DeviceLightHive.instance.editDevice(device);
        hideLoadingDialog();
      }
    } else if (!newValue && isCold) {
      showLoadingDialog();
      if (await SmartLightLogic().setHotLightDevice(device)) {
        setState(() {
          device.colorTemp = 500;
        });
        //DeviceLightHive.instance.editDevice(device);
        hideLoadingDialog();
      }
    }
  }

  void handleLightBrightness(double newValue) async {
    int brightness = (newValue * 250).toInt();
    showLoadingDialog();
    if (await SmartLightLogic().setBrightnessLightDevice(device, brightness)) {
      if (brightness == 0) {
        device.enabled = false;
      }
      if (brightness > 0) {
        device.enabled = true;
      }
      setState(() {
        device.brightness = brightness;
        //DeviceLightHive.instance.editDevice(device);
        intensityValue = device.brightness / 250;
      });
    } else {
      setState(() {
        intensityValue = startScroll;
      });
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
    loadDeviceValue();
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
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation1, animation2) =>
                                                const DevicePage(),
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration: Duration.zero,
                                      ),
                                      (route) => false);
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
                                      value: device.enabled,
                                      onChanged: (newValue) {
                                        handleLightState(newValue);
                                      },
                                      trackOutlineColor:
                                          MaterialStateProperty.resolveWith(
                                        (final Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.selected)) {
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
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 2.2),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/lamp.png',
                                height: 1000.h,
                              ),
                              SizedBox(
                                width: 750.0.w,
                                height: 700.h,
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: device.enabled && isCold,
                                      child: Image.asset(
                                        'assets/images/purple.png',
                                        scale: 1,
                                      )
                                          .animate(controller: lightController)
                                          .fadeIn(
                                              duration: const Duration(
                                                  milliseconds: 400)),
                                    ),
                                    Visibility(
                                      visible: device.enabled && !isCold,
                                      child: Image.asset(
                                        'assets/images/orange.png',
                                        scale: 1,
                                      )
                                          .animate(controller: lightController)
                                          .fadeIn(
                                              duration: const Duration(
                                                  milliseconds: 400)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 150.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 120.w),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Tonalità',
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 70.sp,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                handleLightTemp(false);
                              },
                              child: Container(
                                height: 130.h,
                                decoration: BoxDecoration(
                                  color: (!isCold)
                                      ? const Color(0xFF464646)
                                      : const Color(0xFFf2f2f2).withOpacity(0.9),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40.r),
                                    bottomLeft: Radius.circular(40.r),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Caldo',
                                    style: TextStyle(
                                      color:
                                          (isCold) ? Colors.black : Colors.white,
                                      fontFamily: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.fontFamily,
                                      fontSize: 60.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                handleLightTemp(true);
                              },
                              child: Container(
                                height: 130.h,
                                decoration: BoxDecoration(
                                  color: (isCold)
                                      ? const Color(0xFF464646)
                                      : const Color(0xFFf2f2f2).withOpacity(0.9),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40.r),
                                    bottomRight: Radius.circular(40.r),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Freddo',
                                    style: TextStyle(
                                      color:
                                          (!isCold) ? Colors.black : Colors.white,
                                      fontFamily: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.fontFamily,
                                      fontSize: 60.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 130.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'Intensità',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.displayLarge?.color,
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 70.sp,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const Spacer(),
                          Text(
                            "${(intensityValue * 100).toInt()}%",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.displayLarge?.color,
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 60.sp,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Slider(
                          value: intensityValue,
                          onChanged: (newValue) {
                            setState(() {
                              intensityValue = newValue;
                            });
                          },
                          onChangeEnd: (double newValue) {
                            setState(() {
                              handleLightBrightness(newValue);
                            });
                          },
                          onChangeStart: (double value) {
                            startScroll = value;
                          },
                          activeColor: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'Off',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.color!
                                  .withOpacity(0.8),
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 40.sp,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const Spacer(),
                          Text(
                            '100%',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.color!
                                  .withOpacity(0.8),
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 40.sp,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            /*
            SlidingUpPanel(
              minHeight: 330.h,
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
                child: SmartLightBodyPopup(
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
