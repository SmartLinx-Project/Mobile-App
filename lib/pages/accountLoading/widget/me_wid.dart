import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../services/auth.dart';

class MeWidget extends StatefulWidget {
  String messageText;
  MeWidget({super.key, required this.messageText});
  @override
  State<MeWidget> createState() => _MeWidgetState();
}

class _MeWidgetState extends State<MeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 100.h),
      child: Row(
        children: [
          const Spacer(),
          SafeArea(
              child: FittedBox(
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Container(
                width: 900.w,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(90.r),
                    bottomLeft: Radius.circular(90.r),
                    bottomRight: Radius.circular(90.r),
                    topRight: Radius.circular(10.r),
                  ),
                ),
                padding: EdgeInsets.all(50.sp),
                child: Text(
                  widget.messageText,
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 60.sp,
                  ),
                  maxLines: 100,
                ),
              ),
            ),
          )),
          SizedBox(
            width: 40.w,
          ),
          (Auth().getProfilePhotoUrl()!.isNotEmpty)
              ? ClipOval(
                  child: Image.network(
                    Auth().getProfilePhotoUrl()!,
                    height: 130.h,
                    width: 130.w,
                    fit: BoxFit.fill,
                  ),
                )
              : ClipOval(
                  child: Image.asset(
                    'assets/images/generic_user.png',
                    height: 130.h,
                    width: 130.w,
                    fit: BoxFit.fill,
                  ),
                ),
        ],
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 250));
  }
}
