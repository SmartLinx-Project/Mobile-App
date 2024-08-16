import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/handleHomes/handle_homes.dart';

class AppBarEditHome extends StatelessWidget implements PreferredSizeWidget {
  const AppBarEditHome({
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
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                  const HandleHomes(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
                  (route) => false
              );
            },
      ),
      centerTitle: true,
      title: Text(
        'Gestisci Casa',
        style: TextStyle(
            color: Theme.of(context).textTheme.displayLarge!.color,
            fontSize: 70.sp),
        textAlign: TextAlign.center,
      ),
    );
  }
}
