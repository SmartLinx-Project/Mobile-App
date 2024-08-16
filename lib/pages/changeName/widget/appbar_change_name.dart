import 'package:flutter/material.dart';
class edit_name_field extends StatelessWidget implements PreferredSizeWidget {
  const edit_name_field({
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
