import 'package:flutter/material.dart';
import 'package:smartlinx/pages/addHome/addhome_page.dart';
import 'package:smartlinx/pages/devicePage/device_page.dart';

class AppBarHandleHomes extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHandleHomes({
    super.key,
    this.onBack,
    this.onAdd,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final Function()? onBack;
  final Function()? onAdd;

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
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const DevicePage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
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
                        const AddHomePage(),
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
