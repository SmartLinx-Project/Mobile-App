import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/handleRooms/handle_room.dart';
import 'package:smartlinx/pages/sharedWidget/loading_animation.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/hiveMethod/room_hive.dart';
import 'package:smartlinx/services/http.dart';

import '../../../services/hive.dart';

class HandleRoomConfirmButtons extends StatefulWidget {
  Room room;
  TextEditingController nameController;
  HandleRoomConfirmButtons(
      {super.key, required this.room, required this.nameController});

  @override
  State<HandleRoomConfirmButtons> createState() =>
      _HandleRoomConfirmButtonsState();
}

class _HandleRoomConfirmButtonsState extends State<HandleRoomConfirmButtons> {
  void editRoom() async {
    Room room = widget.room;
    String nameText = widget.nameController.text;
    if (nameText.isNotEmpty && room.name != nameText) {
      LoadingAnimation loadingAnimation = LoadingAnimation(context);
      loadingAnimation.showLoading();
      if (await HttpService().setRoom(roomID: room.roomID, name: nameText)) {
        loadingAnimation.showFinal();
        room.name = nameText;
        RoomHive.instance.insertRoom(room);
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => HandleRoom(
              home: HomeHive.instance.getHomeFromID(room.homeID),
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      } else {
        loadingAnimation.dispose();
      }
    }
  }

  void delRoom() async {
    LoadingAnimation loadingAnimation = LoadingAnimation(context);
    loadingAnimation.showLoading();
    if (await HttpService().delRoom(roomID: widget.room.roomID)) {
      loadingAnimation.showFinal();
      RoomHive.instance.removeRoom(widget.room.roomID);
      checkCurrentRoom();
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => HandleRoom(
                home: HomeHive.instance.getHomeFromID(widget.room.homeID)),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
          (route) => false);
    } else {
      loadingAnimation.dispose();
    }
  }

  void checkCurrentRoom(){
    int currentRoomID = RoomHive.instance.getCurrentRoom()!;
    List<Room> rooms = RoomHive.instance.getRoomsFromHomeID(widget.room.homeID);
    if(widget.room.roomID == currentRoomID){
      if(rooms.isNotEmpty){
        RoomHive.instance.setCurrentRoom(rooms[0].roomID);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            delRoom();
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
        const Spacer(),
        TextButton(
          onPressed: () {
            editRoom();
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
