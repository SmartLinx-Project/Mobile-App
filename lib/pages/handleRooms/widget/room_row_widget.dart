import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../services/hive.dart';
import '../../editRoom/editroom_page.dart';

class RoomRowWidget extends StatefulWidget {
  Room room;

  RoomRowWidget({super.key, required this.room});

  @override
  State<RoomRowWidget> createState() => _StanzeRowWidget();
}

class _StanzeRowWidget extends State<RoomRowWidget> {
  late String _name;

  @override
  void initState() {
    super.initState();
    _name = widget.room.name;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditRoomPage(room: widget.room,)),
        );
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _name,
                style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.displayMedium?.fontFamily,
                  color: Theme.of(context).textTheme.displayLarge?.color!.withOpacity(0.9),
                  fontSize: 60.sp,
                ),
              ),
              Icon(
                Icons.menu,
                color: Theme.of(context).textTheme.displayLarge?.color,
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Divider(
            thickness: 1.0,
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
