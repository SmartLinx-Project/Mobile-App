import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/devicePage/widget/addHubPopup/finishconf_popup.dart';
import 'package:smartlinx/pages/devicePage/widget/addHubPopup/hubfound_popup.dart';
import 'package:smartlinx/pages/devicePage/widget/addHubPopup//hubloading_popup.dart';
import 'package:smartlinx/pages/devicePage/widget/addHubPopup/introduction_popup.dart';
import 'package:smartlinx/pages/devicePage/widget/addHubPopup/qrcode_popup.dart';
import 'package:smartlinx/pages/devicePage/widget/addHubPopup/selecthome_popup.dart';

class ModalPopup {
  static void show(BuildContext context, int homeID, Function refreshDevicePage) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(180.r),
        ),
      ),
      builder: (BuildContext context) {
        return _AnimatedContentSwitcher(homeID: homeID, refreshDevicePage: refreshDevicePage);
      },
      isScrollControlled: true,
    );
  }
}


class _AnimatedContentSwitcher extends StatefulWidget {
  final int homeID;
  final Function refreshDevicePage;

  const _AnimatedContentSwitcher({required this.homeID, required this.refreshDevicePage});

  @override
  __AnimatedContentSwitcherState createState() => __AnimatedContentSwitcherState(homeID: homeID, refreshDevicePage: refreshDevicePage);
}


class __AnimatedContentSwitcherState extends State<_AnimatedContentSwitcher>
    with SingleTickerProviderStateMixin {
  int homeID;
  Function refreshDevicePage;
  __AnimatedContentSwitcherState({required this.homeID, required this.refreshDevicePage});
  int _actualWidget = 1;
  int hubID = 0;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  @override
  void initState() {
    super.initState();
  }

  void setHubID(int hub){
    hubID = hub;
  }

  void _toggleWidget(int index) async {
    _actualWidget = index;
    if(_actualWidget != 7){
      _controller.forward();
    }
    await Future.delayed(const Duration(milliseconds: 300));
    _controller.reset();
    setState(() {});
    if(_actualWidget != 7){
      setState(() {});
    }
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
            return QrcodePopup(toggleCallback: _toggleWidget, setHubID: setHubID,);
          case 3:
            return HubFoundPopup(toggleCallback: _toggleWidget);
          case 4:
            return HubLoadingPopup(
              toggleCallback: _toggleWidget,
              homeID: homeID,
              hubID: hubID,
            );
          case 5:
            return SelectHomePopup(
              toggleCallback: _toggleWidget,
            );
          case 6:
            return FinishConfPopup(toggleCallback: _toggleWidget);
          case 7:
            reload();
        }
      })(),
    );
  }

void reload() async{
  Navigator.pop(context);
  await Future.delayed(const Duration(milliseconds: 600));
  widget.refreshDevicePage();
}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
