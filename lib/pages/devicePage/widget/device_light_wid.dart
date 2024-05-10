import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popover/popover.dart';
import 'package:smartlinx/pages/smartlLight/smartlight_page.dart';
import 'package:smartlinx/services/hive.dart';
import '../../smartlLight/smartlight_logic.dart';
import '../menuItems/menu_bar.dart';
import 'package:vibration/vibration.dart';

class DeviceLightWidget extends StatefulWidget {
  DeviceLight device;
  Function refreshPage;

  DeviceLightWidget({super.key, required this.device, required this.refreshPage});

  @override
  State<DeviceLightWidget> createState() => _DeviceLightWidgetState();
}

class _DeviceLightWidgetState extends State<DeviceLightWidget> {

  bool isLoading = false;
  late DeviceLight device;

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

  void handleLightState(bool newValue) async{
    showLoadingDialog();
    if(!device.enabled){
      if(await SmartLightLogic().turnOnLightDevice(device)){
       setState(() {
         device.enabled = newValue;
       });
      }
    } else{
      if(await SmartLightLogic().turnOffLightDevice(device)){
        setState(() {
          device.enabled = newValue;
        });
      }
    }
    hideLoadingDialog();
  }

  @override
  Widget build(BuildContext context) {
    device = widget.device;
    return GestureDetector(
      onLongPress: () {
        Vibration.vibrate(duration: 10);
        showPopover(
            context: context,
            radius: 35.sp,
            transitionDuration: const Duration(milliseconds: 100),
            width: 570.w,
            height: 250.h,
            bodyBuilder: (context) => MenuBarItems(deviceID: widget.device.deviceID, type: 0, refreshPage: widget.refreshPage),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            direction: PopoverDirection.top);
      },
      onTap: () {
        if (widget.device.isOnline) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  SmartLightPage(device: widget.device,),
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
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/light.svg',
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
                    Transform.scale(
                      scale: 0.6,
                      child: Switch(
                        value: device.enabled,
                        onChanged: (index) {
                          handleLightState(index);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
