import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/http.dart';

class SelectHomePopup extends StatefulWidget {
  final void Function(int)? toggleCallback;
  final Map<String, dynamic> device;
  final Function setDeviceName;
  const SelectHomePopup(
      {super.key,
      required this.toggleCallback,
      required this.device,
      required this.setDeviceName});
  @override
  State<SelectHomePopup> createState() => _SelectHomePopupState();
}

class _SelectHomePopupState extends State<SelectHomePopup>
    with WidgetsBindingObserver {
  final TextEditingController _nameController = TextEditingController();
  late double popupHeight;
  bool clicked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    setState(() {
      if (keyboardHeight > 0) {
        popupHeight = MediaQuery.of(context).size.height * 0.5 + keyboardHeight;
      } else {
        popupHeight = MediaQuery.of(context).size.height * 0.5;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    didChangeMetrics();
    return SafeArea(
      child: Container(
        height: popupHeight,
        padding: EdgeInsets.symmetric(horizontal: 170.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 200.h,
            ),
            Text(
              widget.device['model'],
              style: TextStyle(
                fontFamily:
                    Theme.of(context).textTheme.displayLarge?.fontFamily,
                color: Theme.of(context).textTheme.displayLarge?.color,
                fontWeight: FontWeight.w500,
                fontSize: 110.sp,
              ),
              textAlign: TextAlign.center,
            ).animate().fade(duration: 700.ms, delay: 100.ms),
            SizedBox(
              height: 200.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nome',
                style: TextStyle(
                  fontFamily:
                      Theme.of(context).textTheme.displayMedium?.fontFamily,
                  color: Theme.of(context).textTheme.displayMedium?.color,
                  fontSize: 70.sp,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 100.w),
                  height: 170.h,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(1),
                    borderRadius: BorderRadius.circular(80.r),
                  ),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge?.color,
                      fontFamily:
                          Theme.of(context).textTheme.displayLarge?.fontFamily,
                      fontWeight: FontWeight.normal,
                      fontSize: 60.sp,
                    ),
                    maxLength: 25,
                  ),
                ),
                Positioned(
                    top: 13.h,
                    left: 940.w,
                    child: IconButton(
                      onPressed: () {
                        _nameController.text = '';
                      },
                      icon: Icon(
                        Icons.close,
                        size: 80.sp,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 300.h,
            ),
            Container(
              width: double.infinity,
              height: 200.h,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 3),
                    blurRadius: 6,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty) {
                    clicked = true;
                    widget.setDeviceName(_nameController.text);
                    widget.toggleCallback!(5);
                  }
                },
                child: Text(
                  'Continua',
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 75.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    )
        .animate()
        .slideX(begin: 1, end: 0, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    if(!clicked){
      HttpService().leaveDevice(
          hubID: HomeHive.instance
              .getHomeFromID(HomeHive.instance.getCurrentHome()!)
              .hubID,
          ieeeAddress: widget.device['ieeeAddress']);
    }
    super.dispose();
  }
}
