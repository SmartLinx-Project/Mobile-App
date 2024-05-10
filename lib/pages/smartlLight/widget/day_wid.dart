import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/smartlLight/widget/repeat_wid.dart';

class DayWidget extends StatefulWidget {
  dayofWeek day;
  String date;
  DayWidget({super.key, required this.date, required this.day});

  @override
  State<DayWidget> createState() => _DayWidgetState();
}

class _DayWidgetState extends State<DayWidget> {
  Color textSelected = const Color(0xFFFFFFFF).withOpacity(0.9);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.day.isSelected = !widget.day.isSelected;
        });
      },
      child: Container(
        height: 320.h,
        width: 320.h,
        decoration: BoxDecoration(
          color: (widget.day.isSelected)
              ? const Color(0xFF464646)
              : Theme.of(context).colorScheme.onSurface,
          borderRadius: BorderRadius.circular(40.r),
          border: Border.all(
              color: (widget.day.isSelected)
                  ? Colors.transparent
                  : Theme.of(context).iconTheme.color!.withOpacity(0.5),
              width: 3.sp),
        ),
        child: Center(
          child: Text(
            widget.date,
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
              color: (widget.day.isSelected)
                  ? textSelected
                  : Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.color!
                      .withOpacity(0.5),
              fontWeight: FontWeight.w500,
              fontSize: 65.sp,
            ),
          ),
        ),
      ),
    );
  }
}
