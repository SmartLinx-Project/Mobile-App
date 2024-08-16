import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/hive.dart';

class SelectHomeMenu extends StatefulWidget {
  Home home;
  Room room;
  SelectHomeMenu({super.key, required this.home, required this.room});

  @override
  State<SelectHomeMenu> createState() => _SelectHomeMenuState();
}

class _SelectHomeMenuState extends State<SelectHomeMenu> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Theme.of(context)
              .primaryColor,
          width: 2.5,
        ),
        color: Theme.of(context).bottomSheetTheme.backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 50.w),
            child: Text(
              'Casa',
              style: TextStyle(
                fontSize: 60.sp,
                color: Theme.of(context).textTheme.displayLarge!.color,
                fontFamily:
                Theme.of(context).textTheme.displayLarge!.fontFamily,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 180.h,
            width: 700.w,
            child: TextField(
              enabled: false,
              style: TextStyle(
                color: Theme.of(context).textTheme.displayMedium!.color,
                fontFamily: Theme.of(context).textTheme.displayMedium!.fontFamily,
              ),
              decoration: InputDecoration(
                hintText: widget.home.name,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
