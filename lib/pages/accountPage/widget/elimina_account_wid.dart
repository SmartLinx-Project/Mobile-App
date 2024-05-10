import 'package:flutter/material.dart' as delete_account_widget;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/accountPage/widget/handle_popup.dart';

class DeleteAccountButton extends delete_account_widget.StatefulWidget {
  const DeleteAccountButton({super.key});

  @override
  delete_account_widget.State<DeleteAccountButton> createState() => _DeleteAccountButtonState();
}

class _DeleteAccountButtonState extends delete_account_widget.State<DeleteAccountButton> {

  @override
  delete_account_widget.Widget build(delete_account_widget.BuildContext context) {
    return delete_account_widget.Container(
      width: 1000.w,
      height: 200.h,
      decoration: delete_account_widget.BoxDecoration(
        color: delete_account_widget.Theme.of(context).colorScheme.primary,
        borderRadius: delete_account_widget.BorderRadius.circular(90.r),
      ),
      child: delete_account_widget.TextButton(
        onPressed: () {
          ModalPopup.show(context);
        },
        child: delete_account_widget.Row(
          mainAxisAlignment: delete_account_widget.MainAxisAlignment.center,
          crossAxisAlignment: delete_account_widget.CrossAxisAlignment.center,
          children: [
            delete_account_widget.Text(
              'Elimina Account',
              style: delete_account_widget.TextStyle(
                fontFamily:
                delete_account_widget.Theme.of(context).textTheme.displayLarge?.fontFamily,
                fontWeight: delete_account_widget.FontWeight.bold,
                fontSize: 68.sp,
                color: delete_account_widget.Colors.white,
              ),
              textAlign: delete_account_widget.TextAlign.center,
            ),
            delete_account_widget.SizedBox(width: 75.w),
            const delete_account_widget.Icon(
              delete_account_widget.Icons.heart_broken_rounded,
              color: delete_account_widget.Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
