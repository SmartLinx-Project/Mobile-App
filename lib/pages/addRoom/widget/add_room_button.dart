import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:smartlinx/pages/handleRooms/handle_room.dart";
import "package:smartlinx/pages/sharedWidget/loading_animation.dart";
import "package:smartlinx/services/http.dart";
import "package:smartlinx/services/init_app.dart";
import "../../../services/hive.dart";

class AddRoomButton extends StatefulWidget {
  Home home;
  TextEditingController nameController;
  AddRoomButton({super.key, required this.home, required this.nameController});

  @override
  State<AddRoomButton> createState() => _AddRoomButtonState();
}

class _AddRoomButtonState extends State<AddRoomButton> {
  void addRoom() async {
    String name = widget.nameController.text;
    LoadingAnimation loadingAnimation = LoadingAnimation(context);
    loadingAnimation.showLoading();
    if (await HttpService().addRoom(homeID: widget.home.homeID, name: name)) {
      await InitApp().startInit();
      loadingAnimation.showFinal();
      await Future.delayed(const Duration(seconds: 2));
      loadingAnimation.dispose();
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              HandleRoom(home: widget.home),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
          (route)=> false
      );
    } else {
      loadingAnimation.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800.w,
      height: 200.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(150.r),
      ),
      child: TextButton(
        onPressed: () {
          addRoom();
        },
        child: Text(
          "Aggiungi Stanza",
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 65.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
