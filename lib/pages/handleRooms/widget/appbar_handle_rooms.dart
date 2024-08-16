import 'package:flutter/material.dart';
import 'package:smartlinx/pages/devicePage/device_page.dart';
import 'package:smartlinx/pages/addRoom/add_room.dart';

import '../../../services/hive.dart';

class AppBarHandleRooms extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHandleRooms({
    super.key,
    this.onBack,
    this.onAdd,
    required this.home,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final Function()? onBack;
  final Function()? onAdd;
  final Home home;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: onBack ??
            () {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const DevicePage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                  (route) => false);
            },
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            size: 40,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: onAdd ??
              () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        AddRoom(home: home),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
        ),
      ],
    );
  }
}
