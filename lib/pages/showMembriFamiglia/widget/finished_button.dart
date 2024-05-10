import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: unused_import
import 'package:smartlinx/pages/homePage/home_page.dart';

class FinishedButtonWidget extends StatefulWidget {
  final int? currentHome;
  const FinishedButtonWidget({super.key, this.currentHome});

  @override
  State<FinishedButtonWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<FinishedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:110,
      height: 160.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(120.r),

      ),
      child: TextButton(
        onPressed: (){
          if(widget.currentHome == null){
            Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                const HomePage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
                  (route) => false,
            );
          } else{
            Navigator.pop(context);
          }
        },
        child: Text(
          'Finito',
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
            fontWeight: FontWeight.normal,
            fontSize: 60.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
