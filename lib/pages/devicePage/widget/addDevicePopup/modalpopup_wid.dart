import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/devicePage/widget/addDevicePopup//finishconf_popup.dart';
import 'package:smartlinx/pages/devicePage/widget/addDevicePopup//devicefound_popup.dart';
import 'package:smartlinx/pages/devicePage/widget/addDevicePopup///deviceloading_popup.dart';
import 'package:smartlinx/pages/devicePage/widget/addDevicePopup//introduction_popup.dart';
import 'package:smartlinx/pages/devicePage/widget/addDevicePopup//scandevice_popup.dart';
import 'package:smartlinx/pages/devicePage/widget/addDevicePopup//selecthome_popup.dart';
import 'package:smartlinx/pages/devicePage/widget/addDevicePopup/error_popup.dart';

class AddDeviceModalPopup {
  static void show(BuildContext context, Function refreshPage) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(180.r),
        ),
      ),
      builder: (BuildContext context) {
        return _AnimatedContentSwitcher(refreshPage: refreshPage);
      },
      isScrollControlled: true,
    );
  }
}

class _AnimatedContentSwitcher extends StatefulWidget {
  final Function refreshPage;
  const _AnimatedContentSwitcher({required this.refreshPage});

  @override
  __AnimatedContentSwitcherState createState() =>
      __AnimatedContentSwitcherState();
}

class __AnimatedContentSwitcherState extends State<_AnimatedContentSwitcher>
    with SingleTickerProviderStateMixin {
  int _actualWidget = 1;
  late Map<String, dynamic> findDevice;
  late String deviceName;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  void setFindDevice(Map<String, dynamic> device) {
    findDevice = device;
  }

  void setDeviceName(String name) {
    deviceName = name;
  }

  @override
  void initState() {
    super.initState();
  }

  void _toggleWidget(int index) async {
    _actualWidget = index;
    if (_actualWidget != 7) {
      _controller.forward();
    }
    await Future.delayed(const Duration(milliseconds: 300));
    _controller.reset();
    setState(() {});
  }

  finish() async {
    Navigator.pop(context);
    await Future.delayed(const Duration(milliseconds: 600));
    widget.refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: const Offset(-1.0, 0.0),
      ).animate(_controller),
      child: (() {
        switch (_actualWidget) {
          case 1:
            return IntroductionPopup(toggleCallback: _toggleWidget);
          case 2:
            return ScanDevice(
              toggleCallback: _toggleWidget,
              setFindDevice: setFindDevice,
            );
          case 3:
            return DeviceFound(
              toggleCallback: _toggleWidget,
              device: findDevice,
            );
          case 4:
            return SelectHomePopup(
              toggleCallback: _toggleWidget,
              device: findDevice,
              setDeviceName: setDeviceName,
            );
          case 5:
            return DeviceLoadingPopup(
              toggleCallback: _toggleWidget,
              deviceInfo: findDevice,
              deviceName: deviceName,
            );
          case 6:
            return FinishConfPopup(
              toggleCallback: _toggleWidget,
              deviceName: deviceName,
              device: findDevice,
            );
          case 7:
            finish();
          case 8:
            return ErrorAddDevicePopup(toggleCallback: _toggleWidget);
        }
      })(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
