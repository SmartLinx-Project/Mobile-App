import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/services/hiveMethod/room_hive.dart';
import '../../../services/hive.dart';

class HandleHomeRoomButton extends StatefulWidget {
  final String text;
  final Home home;
  const HandleHomeRoomButton({super.key, required this.text, required this.home});

  @override
  State<HandleHomeRoomButton> createState() => _HandleHomeRoomButtonState();
}

class _HandleHomeRoomButtonState extends State<HandleHomeRoomButton> {
  late String text;
  late int roomNumber;

  @override
  void initState() {
    super.initState();
    text = widget.text;
    List<Room> rooms = RoomHive.instance.getRoomsFromHomeID(widget.home.homeID);
    roomNumber = rooms.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2.5,
        ),
        color: Theme.of(context).bottomSheetTheme.backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 50.w),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 60.sp,
                color: Theme.of(context).textTheme.displayLarge!.color,
                fontFamily:
                Theme.of(context).textTheme.displayLarge!.fontFamily,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          Text(
            roomNumber.toString(),
            style: TextStyle(
              fontSize: 60.sp,
              color: Theme.of(context).textTheme.displayMedium!.color,
              fontFamily:
              Theme.of(context).textTheme.displayMedium!.fontFamily,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 180.w,
          ),
        ],
      ),
    );
  }
}