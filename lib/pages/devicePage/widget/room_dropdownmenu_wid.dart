import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../services/hive.dart';
import '../../../services/hiveMethod/home_hive.dart';
import '../../../services/hiveMethod/room_hive.dart';

class RoomDropDownMenuWidget extends StatefulWidget {
  Function refreshpageCallback;

  RoomDropDownMenuWidget({super.key, required this.refreshpageCallback});

  @override
  State<RoomDropDownMenuWidget> createState() => _RoomDropDownMenuWidgetState();
}

class _RoomDropDownMenuWidgetState extends State<RoomDropDownMenuWidget> {
  late int _selectedItemId;
  late List<Room> itemNames;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Home selectedHome = HomeHive.instance.getHomeFromID(HomeHive.instance.getCurrentHome()!);
    _selectedItemId = RoomHive.instance.getCurrentRoom()!;
    itemNames = RoomHive.instance.getRoomsFromHomeID(selectedHome.homeID);
    Room selectedRoom = RoomHive.instance.getRoomFromID(_selectedItemId);
    return Row(
      children: [
        PopupMenuButton<Room>(
          offset: Offset(0, 120.h),
          color: Theme.of(context).colorScheme.onSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.r),
          ),
          enableFeedback: true,
          onSelected: (Room selectedRoom) {
            setState(() {
              RoomHive.instance.setCurrentRoom(selectedRoom.roomID);
              _selectedItemId = selectedRoom.roomID;
              widget.refreshpageCallback(selectedRoom);
            });
          },
          itemBuilder: (BuildContext context) {
            return itemNames.map((room) {
              return PopupMenuItem<Room>(
                value: room,
                child: Text(
                  room.name,
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    fontSize: 50.sp,
                  ),
                ),
              );
            }).toList();
          },
          child: Row(
            children: [
              Text(
                selectedRoom.name,
                style: TextStyle(
                  fontFamily:
                      Theme.of(context).textTheme.displayLarge?.fontFamily,
                  color: Theme.of(context).textTheme.displayLarge?.color,
                  fontSize: 110.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.arrow_drop_down_outlined,
                size: 90.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
