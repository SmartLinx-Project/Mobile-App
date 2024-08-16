import 'package:flutter/material.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/hiveMethod/room_hive.dart';
import '../../../services/hive.dart';
import 'devicelist_wid.dart';

class PageViewWidget extends StatefulWidget {
  PageController? pageController;
  Function refreshPage;

  PageViewWidget(
      {super.key, required this.pageController, required this.refreshPage});

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  late Widget pageViewWidget;

  Future<void> fillRoomWidget() async {
    int currentHomeID = HomeHive.instance.getCurrentHome()!;
    List<DeviceListWidget> roomPage = [];

    List<Room> rooms = RoomHive.instance.getRoomsFromHomeID(currentHomeID);

    for (int i = 0; i < rooms.length; i++) {
      DeviceListWidget listRoomWidget =
      DeviceListWidget(roomID: rooms[i].roomID, refreshDevicePage: widget.refreshPage,);
      roomPage.add(listRoomWidget);
    }

    setState(() {
      pageViewWidget = PageView(
        scrollDirection: Axis.horizontal,
        controller: widget.pageController,
        children: roomPage,
        onPageChanged: (index) {
          pageChange(index);
        },
      );
    });
  }

  void pageChange(int index) {
    int currentRoomID = RoomHive.instance.getCurrentRoom()!;
    Room currentRoom = RoomHive.instance.getRoomFromID(currentRoomID);
    List<Room> rooms = RoomHive.instance.getRoomsFromHomeID(currentRoom.homeID);
    for (int i = 0; i < rooms.length; i++) {
      if (i == index) {
        int newRoomID = RoomHive.instance.getRoomFromID(rooms[i].roomID).roomID;
        RoomHive.instance.setCurrentRoom(newRoomID);
      }
    }
    widget.refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    fillRoomWidget();
    return pageViewWidget;
  }
}
