import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/handleRooms/widget/no_room_found.dart';
import 'package:smartlinx/pages/handleRooms/widget/finished_button.dart';
import 'package:smartlinx/pages/handleRooms/widget/room_row_widget.dart';
import 'package:smartlinx/services/hiveMethod/room_hive.dart';

import '../../../services/hive.dart';

class StanzeGrid extends StatefulWidget {
  final Home home;
  const StanzeGrid({super.key, required this.home});

  @override
  State<StanzeGrid> createState() => _StanzeGridState();
}

class _StanzeGridState extends State<StanzeGrid> {
  final List<Widget> _membersWidget = [];

  @override
  void initState() {
    super.initState();
    _addMembers();
  }

  void _addMembers() {
    List<Room> rooms = RoomHive.instance.getRoomsFromHomeID(widget.home.homeID);

    for (var room in rooms) {
      _membersWidget.add(
        Column(
          children: [
            RoomRowWidget(room: room),
            SizedBox(height: 50.h),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _membersWidget.isNotEmpty ? _buildStanzeGrid() : const NoRoomFound(),
      ],
    );
  }

  Widget _buildStanzeGrid() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: BorderRadius.circular(80.r),
          ),
          height: 1400.h,
          width: 3000.h,
          child: Padding(
            padding: EdgeInsets.all(100.h),
            child: ListView(
              children: _membersWidget,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        const FinishedButton(),
      ],
    );
  }
}
