import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimation {
  final BuildContext context;

  LoadingAnimation(this.context);

  void showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              width: 450.w,
              height: 450.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                color: Theme.of(context).cardColor,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: LoadingAnimationWidget.inkDrop(
                  color: Theme.of(context).colorScheme.primary,
                  size: 200.w,
                ),
              ),
            ),
          ),
        ),
      )
    );
  }

  void showFinal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              width: 450.w,
              height: 450.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                color: Theme.of(context).cardColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: Image(
                      image: const AssetImage("assets/images/finito.png"),
                      width: 300.w,
                      height: 300.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void dispose() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
