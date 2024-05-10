import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../services/hive.dart';
import '../../../services/hiveMethod/home_hive.dart';
import '../../../services/hiveMethod/room_hive.dart';

class HomeDropMenu extends StatefulWidget {
  final Function refreshPageCallback;

  const HomeDropMenu({super.key, required this.refreshPageCallback});

  @override
  State<HomeDropMenu> createState() => _HomeDropMenuState();
}

class _HomeDropMenuState extends State<HomeDropMenu> {
  late int _selectedItemId;
  late List<Home> itemNames;

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }

  void hideLoadingDialog() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _selectedItemId = HomeHive.instance.getCurrentHome()!;
    itemNames = HomeHive.instance.getAllHomes();
  }

  @override
  Widget build(BuildContext context) {
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
          onSelected: (Home selectedHome) async{
            _selectedItemId = selectedHome.homeID;
            showLoadingDialog();
            await HomeHive.instance.setCurrentHome(_selectedItemId);
            hideLoadingDialog();
            if (RoomHive.instance
                .getRoomsFromHomeID(_selectedItemId)
                .isNotEmpty) {
              await RoomHive.instance.setCurrentRoom(RoomHive.instance
                  .getRoomsFromHomeID(HomeHive.instance.getCurrentHome()!)[0]
                  .roomID);
            }
            widget.refreshPageCallback();
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
