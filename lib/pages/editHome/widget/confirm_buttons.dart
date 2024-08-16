import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/handleHomes/handle_homes.dart';
import 'package:smartlinx/pages/sharedWidget/loading_animation.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/http.dart';
import '../../../services/hive.dart';

class HandleHomeConfirmButtons extends StatefulWidget {
  final Function editHome;
  final Home home;
  const HandleHomeConfirmButtons(
      {super.key, required this.editHome, required this.home});

  @override
  State<HandleHomeConfirmButtons> createState() =>
      _HandleHomeConfirmButtonsState();
}

class _HandleHomeConfirmButtonsState extends State<HandleHomeConfirmButtons> {
  void delHome() async {
    LoadingAnimation loadingAnimation = LoadingAnimation(context);
    loadingAnimation.showLoading();
    if (await HttpService().delHome(homeID: widget.home.homeID)) {
      loadingAnimation.showFinal();
      HomeHive.instance.removeHome(widget.home.homeID);
      checkCurrentHome();
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                const HandleHomes(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
          (route) => false);
    } else {
      loadingAnimation.dispose();
    }
  }

  void checkCurrentHome() {
    int currentHomeID = HomeHive.instance.getCurrentHome()!;
    List<Home> homes = HomeHive.instance.getAllHomes();
    if (widget.home.homeID == currentHomeID) {
      if (homes.isNotEmpty) {
        HomeHive.instance.setCurrentHome(homes[0].homeID);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if(widget.home.isOwner)
        TextButton(
          onPressed: () async {
            delHome();
          },
          child: Container(
            alignment: Alignment.center,
            height: 200.h,
            width: 500.w,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Text(
              'Elimina',
              style: TextStyle(
                fontSize: 70.sp,
                color: Colors.white,
                fontFamily:
                    Theme.of(context).textTheme.displayLarge!.fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if(widget.home.isOwner)
        const Spacer(),
        TextButton(
          onPressed: () {
            widget.editHome();
          },
          child: Container(
            alignment: Alignment.center,
            height: 200.h,
            width: 500.w,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Text(
              'Salva',
              style: TextStyle(
                fontSize: 70.sp,
                color: Colors.white,
                fontFamily:
                    Theme.of(context).textTheme.displayLarge!.fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}