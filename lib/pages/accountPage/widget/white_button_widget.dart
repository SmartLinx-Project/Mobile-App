  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';

  class WhiteButtonWidget extends StatefulWidget {
    final Function(int) toggleCallback;
    final String testo;
    const WhiteButtonWidget({super.key, required  this.toggleCallback, required this.testo});

    @override
    State<WhiteButtonWidget> createState() => _TornaAlLoginButton();
  }

  class _TornaAlLoginButton extends State<WhiteButtonWidget> {
    @override
    Widget build(BuildContext context) {
      return Container(
        width: double.infinity,
        height: 200.h,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          onPressed: (){
            widget.toggleCallback(2);
          },
          child: Text(
            widget.testo,
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 80.sp,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }
