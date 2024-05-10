import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoRoomFound extends StatelessWidget {
  const NoRoomFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Text(
            "Non ci sono stanze!\n\nClicca sul + per aggiungere le stanze",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily:
              Theme.of(context).textTheme.displayMedium?.fontFamily,
              color: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.color!
                  .withOpacity(1),
              fontWeight: FontWeight.w500,
              fontSize: 50.sp,
            ),
          ),
        ],
      ),
    );
  }
}
