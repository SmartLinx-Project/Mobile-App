import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../services/hive.dart';
import '../../../services/hiveMethod/home_hive.dart';
import '../../../services/hiveMethod/room_hive.dart';

class HomeDropDownMenuWidget extends StatefulWidget {
  Function refreshPageCallback;

  HomeDropDownMenuWidget({super.key, required this.refreshPageCallback});

  @override
  State<HomeDropDownMenuWidget> createState() => _HomeDropDownMenuWidgetState();
}

class _HomeDropDownMenuWidgetState extends State<HomeDropDownMenuWidget> {
  late int _selectedItemId;
  late List<Home> itemNames;

  @override
  void initState() {
    super.initState();
    _selectedItemId = HomeHive.instance.getCurrentHome()!;
    itemNames = HomeHive.instance.getAllHomes();
  }

  @override
  Widget build(BuildContext context) {
    _selectedItemId = HomeHive.instance.getCurrentHome()!;
    itemNames = HomeHive.instance.getAllHomes();
    Home selectedHome = HomeHive.instance.getHomeFromID(_selectedItemId);
    return Row(
      children: [
        PopupMenuButton<Home>(
          offset: Offset(0, 120.h),
          color: Theme.of(context).colorScheme.onSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.r),
          ),
          enableFeedback: true,
          onSelected: (Home selectedHome) async {
            if (selectedHome.homeID != _selectedItemId) {
              setState(() {
                _selectedItemId = selectedHome.homeID;
              });
              HomeHive.instance.setCurrentHome(_selectedItemId);
              if (RoomHive.instance
                  .getRoomsFromHomeID(HomeHive.instance.getCurrentHome()!)
                  .isNotEmpty) {
                RoomHive.instance.setCurrentRoom(RoomHive.instance
                    .getRoomsFromHomeID(HomeHive.instance.getCurrentHome()!)[0]
                    .roomID);
              }
              widget.refreshPageCallback();
            }
          },
          itemBuilder: (BuildContext context) {
            return itemNames.map((home) {
              return PopupMenuItem<Home>(
                value: home,
                child: Text(
                  home.name,
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
                selectedHome.name,
                style: TextStyle(
                  fontFamily:
                      Theme.of(context).textTheme.displayLarge?.fontFamily,
                  color: Theme.of(context).textTheme.displayLarge?.color,
                  fontSize: 70.sp,
                  fontWeight: FontWeight.normal,
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
