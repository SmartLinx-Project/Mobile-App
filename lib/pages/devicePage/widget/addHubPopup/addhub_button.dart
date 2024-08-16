import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/devicePage/widget/addHubPopup/modalpopup_wid.dart';
class AddHubButton extends StatefulWidget {
  int homeID;
  Function refreshPage;
  AddHubButton({super.key, required this.homeID, required this.refreshPage});

  @override
  State<AddHubButton> createState() => _AddHubButtonBtnState();
}
class _AddHubButtonBtnState extends State<AddHubButton> {
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
          ModalPopup.show(context, widget.homeID, widget.refreshPage);
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

