import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoutineTimePicker extends StatefulWidget {
  final DateTime initialTime;
  final Function updateTime;
  const RoutineTimePicker({super.key, required this.initialTime, required this.updateTime});

  @override
  State<RoutineTimePicker> createState() => _RoutineTimePickerState();
}

class _RoutineTimePickerState extends State<RoutineTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70.r),
        color: Theme.of(context).colorScheme.onSurface,
      ),
      child: Padding(
        padding: EdgeInsets.all(80.w),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Ora',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.w500,
                    fontSize: 75.sp,
                  ),
                  textAlign: TextAlign.left,
                ),
                const Spacer(),
              ],
            ),
            SizedBox(
              height: 100.h,
            ),
            SizedBox(
              height: 500.h,
              child: CupertinoDatePicker(
                onDateTimeChanged: (newTime) {
                  widget.updateTime(newTime);
                },
                mode: CupertinoDatePickerMode.time,
                use24hFormat: true,
                initialDateTime: widget.initialTime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
