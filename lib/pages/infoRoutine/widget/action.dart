import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SingleRoutineAction extends StatefulWidget {
  final String deviceName;
  final String iconPath;
  final String roomName;
  final String action;
  const SingleRoutineAction({super.key, required this.deviceName, required this.iconPath, required this.roomName, required this.action});

  @override
  State<SingleRoutineAction> createState() => _SingleRoutineActionState();
}

class _SingleRoutineActionState extends State<SingleRoutineAction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(100.r),
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.r),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  SvgPicture.asset(
                    widget.iconPath,
                    height: 100.sp,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  SizedBox(
                    width: 90.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.deviceName,
                        style: TextStyle(
                          color:
                          Theme.of(context).textTheme.displayLarge?.color,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.fontFamily,
                          fontWeight: FontWeight.w500,
                          fontSize: 62.sp,
                        ),
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      Text(
                        widget.roomName,
                        style: TextStyle(
                          color:
                          Theme.of(context).textTheme.displayLarge?.color,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.fontFamily,
                          fontWeight: FontWeight.normal,
                          fontSize: 43.sp,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 8.w,
                      ),
                      Text(
                        'Azione: ${widget.action}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.fontFamily,
                          fontWeight: FontWeight.normal,
                          fontSize: 43.sp,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
