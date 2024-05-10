import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/homePage/home_page.dart';

class SaveRoomButton extends StatefulWidget {
  const SaveRoomButton({super.key});

  @override
  State<SaveRoomButton> createState() => _SaveRoomButtonState();
}
class _SaveRoomButtonState extends State<SaveRoomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.325,
      height: 200.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(100.r),

      ),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        },
        child: Text(
          'Salva',
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 65.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

