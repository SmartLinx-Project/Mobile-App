import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/addHome/addhome_page.dart';

class AddButton extends StatefulWidget {
  const AddButton({super.key});

  @override
  State<AddButton> createState() => _AddHubButtonState();
}
class _AddHubButtonState extends State<AddButton> {
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
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddHomePage(),
            ),
          );
        },
        child: Text(
          'Aggiungi',
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
            fontWeight: FontWeight.normal,
            fontSize: 60.sp,
            color: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
    );
  }
}

