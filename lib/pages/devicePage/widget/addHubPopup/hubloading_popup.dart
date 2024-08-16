import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smartlinx/services/http.dart';
import 'package:smartlinx/services/init_app.dart';

class HubLoadingPopup extends StatefulWidget {
  final void Function(int)? toggleCallback;
  int hubID;
  int homeID;
  HubLoadingPopup({super.key, this.toggleCallback, required this.hubID, required this.homeID});

  @override
  State<HubLoadingPopup> createState() => _HubLoadingPopupState();
}

class _HubLoadingPopupState extends State<HubLoadingPopup> {

  Future<void> pairHub() async{

    if(await HttpService().setHub(homeID: widget.homeID, hubID: widget.hubID)){
      await InitApp().startInit();
      widget.toggleCallback!(6);
    } else{
      widget.toggleCallback!(5);
    }
  }
  @override
  void initState() {
    super.initState();
    pairHub();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 1500.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 170.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 70.h,
            ),
            Text(
              "SmartLinx Hub",
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
              height: 70.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 200.h),
              child: LoadingAnimationWidget.inkDrop(
                color: Theme.of(context).colorScheme.primary,
                size: 300.w,
              ),
            ).animate().fade(duration: 700.ms, delay: 100.ms),
            SizedBox(
              height: 100.h,
            ),
            Text(
              "Connessione in corso...",
              style: TextStyle(
                fontFamily:
                Theme.of(context).textTheme.displayLarge?.fontFamily,
                color: Theme.of(context).textTheme.displayLarge?.color,
                fontWeight: FontWeight.normal,
                fontSize: 90.sp,
              ),
              textAlign: TextAlign.center,
            ).animate().fade(duration: 700.ms, delay: 100.ms),
            SizedBox(
              height: 130.h,
            ),
          ],
        ),
      ),
    ).animate().slideX(begin: 1, end: 0, duration: const Duration(milliseconds: 300));
  }
}
