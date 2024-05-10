import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/handleRooms/widget/no_room_found.dart';
import 'package:smartlinx/pages/handleRooms/widget/appbar_handle_rooms.dart';
import 'package:smartlinx/pages/handleRooms/widget/grid_room_widget.dart';
import 'package:smartlinx/services/hiveMethod/room_hive.dart';

import '../../services/hive.dart';

class HandleRoom extends StatefulWidget {
  Home home;
  HandleRoom({super.key, required this.home});

  @override
  State<HandleRoom> createState() => _HandleRoomState();
}

class _HandleRoomState extends State<HandleRoom> {

  bool haveRooms = false;

  void checkRooms(){
    List<Room> rooms = RoomHive.instance.getRoomsFromHomeID(widget.home.homeID);
    if(rooms.isNotEmpty){
      haveRooms = true;
    }
  }

  @override
  void initState() {
    super.initState();
    checkRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHandleRooms(home: widget.home,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(150.w, 150.h, 150.w, 150.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Stanze",
                style: TextStyle(
                  fontFamily:
                      Theme.of(context).textTheme.displayLarge?.fontFamily,
                  color: Theme.of(context).textTheme.displayLarge?.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 120.sp,
                ),
              ),
              Text(
                "Gestisci le tue stanze",
                style: TextStyle(
                  fontFamily:
                      Theme.of(context).textTheme.displayMedium?.fontFamily,
                  color: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.color!
                      .withOpacity(1),
                  fontWeight: FontWeight.w500,
                  fontSize: 65.sp,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              haveRooms ? StanzeGrid(home: widget.home) : const NoRoomFound(),
            ],
          ),
        ),
      ),
    );
  }
}
