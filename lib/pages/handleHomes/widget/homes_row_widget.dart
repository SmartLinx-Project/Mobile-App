import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/editHome/edithome_page.dart';

import '../../../services/hive.dart';

class HomesRowWidget extends StatefulWidget {
  final Home home;

  const HomesRowWidget({super.key, required this.home});

  @override
  State<HomesRowWidget> createState() => _HomesRowWidgetState();
}

class _HomesRowWidgetState extends State<HomesRowWidget> {
  late String _name;

  @override
  void initState() {
    super.initState();
    _name = widget.home.name;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                EditHomePage(home: widget.home),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _name,
                style: TextStyle(
                  fontFamily:
                      Theme.of(context).textTheme.displayMedium?.fontFamily,
                  color: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.color!
                      .withOpacity(0.9),
                  fontSize: 60.sp,
                ),
              ),
              Icon(
                Icons.menu,
                color: Theme.of(context).textTheme.displayLarge?.color,
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Divider(
            thickness: 1.0,
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
