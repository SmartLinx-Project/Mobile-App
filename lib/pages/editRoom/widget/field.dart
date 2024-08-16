import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HandleRoomField extends StatefulWidget {
  String text;
  TextEditingController controller;
  HandleRoomField({super.key, required this.text, required this.controller});

  @override
  State<HandleRoomField> createState() => _HandleRoomFieldState();
}

class _HandleRoomFieldState extends State<HandleRoomField> {

  late String text;

  @override
  void initState() {
    super.initState();
    text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Theme.of(context)
              .primaryColor,
          width: 2.5,
        ),
        color: Theme.of(context).bottomSheetTheme.backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 50.w),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 60.sp,
                color: Theme.of(context).textTheme.displayLarge!.color,
                fontFamily:
                Theme.of(context).textTheme.displayLarge!.fontFamily,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 180.h,
            width: 700.w,
            child: TextField(
              controller: widget.controller,
              style: TextStyle(
                color: Theme.of(context).textTheme.displayMedium!.color,
                fontFamily: Theme.of(context).textTheme.displayMedium!.fontFamily,
              ),
              decoration: const InputDecoration(
                hintText: 'Inserisci testo',
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
