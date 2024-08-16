import 'package:flutter/material.dart';

class AppBarChangePassword extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarChangePassword({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
