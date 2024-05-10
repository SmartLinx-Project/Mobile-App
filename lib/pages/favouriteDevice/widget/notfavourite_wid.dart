import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotFavouriteDeviceWidget extends StatelessWidget {
  const NotFavouriteDeviceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Non hai dispositivi preferiti!',
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.color!
                  .withOpacity(0.8),
              fontFamily: Theme.of(context).textTheme.displayMedium?.fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 65.sp,
            ),
          ),
          SizedBox(
            height: 60.h,
          ),
          Icon(
            Icons.star_outline_outlined,
            size: 150.w,
            color: Theme.of(context)
                .textTheme
                .displayMedium
                ?.color!
                .withOpacity(0.8),
          ),
        ],
      ),
    );
  }
}
