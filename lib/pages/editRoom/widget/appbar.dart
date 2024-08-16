import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarEditRoom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarEditRoom({
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
              Navigator.pop(context);
            },
      ),
      centerTitle: true,
      title: Text(
        'Gestisci Stanza',
        style: TextStyle(
            color: Theme.of(context).textTheme.displayLarge!.color,
            fontSize: 70.sp),
        textAlign: TextAlign.center,
      ),
    );
  }
}
