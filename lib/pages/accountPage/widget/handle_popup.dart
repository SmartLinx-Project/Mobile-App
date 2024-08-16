import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/accountPage/widget/delete_account_popup.dart';
import 'package:smartlinx/pages/accountPage/widget/opzioni_elimina_account_popup.dart';

class ModalPopup {
  static void show(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(180.r),
        ),
      ),
      builder: (BuildContext context) {
        return _AnimatedContentSwitcher();
      },
      isScrollControlled: true,
    );
  }
}
class _AnimatedContentSwitcher extends StatefulWidget {
  @override
  __AnimatedContentSwitcherState createState() =>
      __AnimatedContentSwitcherState();
}

class __AnimatedContentSwitcherState extends State<_AnimatedContentSwitcher>
    with SingleTickerProviderStateMixin {
  int _actualWidget = 1;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleWidget(int index) async {
    _actualWidget = index;
    if (_actualWidget != 3) {
      _controller.forward();
    }
    await Future.delayed(const Duration(milliseconds: 300));
    _controller.reset();
    setState(() {});
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
            return DeleteAccountOptions(toggleCallback: _toggleWidget);
          case 2:
            return DeleteAccountPopup(toggleCallback: _toggleWidget);
          case 3:
            Navigator.pop(context);
            break;

        }
      })(),
    );
  }
}
