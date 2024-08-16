import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smartlinx/services/init_app.dart';

class TryAgainWidget extends StatefulWidget {
  final Function refreshPage;
  const TryAgainWidget({super.key, required this.refreshPage});

  @override
  State<TryAgainWidget> createState() => _TryAgainWidgetState();
}

class _TryAgainWidgetState extends State<TryAgainWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 440.w,
      height: 150.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(1),
        borderRadius: BorderRadius.circular(150.r),
      ),
      child: TextButton(
        onPressed: () async {
          if (!isLoading == true) {
            setState(() {
              isLoading = true;
            });
            await InitApp().startInit();
            widget.refreshPage();
            isLoading = false;
          }
        },
        child: (!isLoading)
            ? Text(
                'Riprova',
                style: TextStyle(
                  fontFamily:
                      Theme.of(context).textTheme.displayLarge?.fontFamily,
                  fontWeight: FontWeight.normal,
                  fontSize: 60.sp,
                  color: Theme.of(context).colorScheme.background,
                ),
              )
            : LoadingAnimationWidget.horizontalRotatingDots(
                color: Colors.white, size: 130.sp),
      ),
    );
  }
}
