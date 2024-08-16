import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function()? onBack;
  final Function()? onAdd;
  final bool owner;

  const CustomAppBar({super.key, this.onBack, this.onAdd, required this.owner});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: onBack ?? () {},
      ),
      actions: [
        (owner)
            ? IconButton(
                icon: Icon(
                  Icons.add,
                  size: 40,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: onAdd ??
                    () {
                      Navigator.pop(context);
                    },
              )
            : Container(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
