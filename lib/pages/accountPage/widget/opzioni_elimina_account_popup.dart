import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/accountPage/widget/CancelDeleteButton.dart';
import 'package:smartlinx/pages/accountPage/widget/white_button_widget.dart';
import 'package:smartlinx/services/auth.dart';
import 'package:smartlinx/services/http.dart';

class DeleteAccountOptions extends StatelessWidget {
  final Function(int) toggleCallback;

  const DeleteAccountOptions({super.key, required this.toggleCallback});

  handleCallback(int index) async{
    await deleteAccount(index);
  }

  Future<void> deleteAccount(int index) async {
    if (await HttpService().deleteUserData()) {
      await Auth().deleteUserByUid(await Auth().getToken());
      toggleCallback(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: EdgeInsets.symmetric(horizontal: 35.w),
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15.w, 30.h, 15.w, 30.h),
              child: Text(
                "Elimina Account",
                style: TextStyle(
                  fontFamily:
                      Theme.of(context).textTheme.displayLarge?.fontFamily,
                  color: Theme.of(context).textTheme.displayLarge?.color,
                  fontWeight: FontWeight.w500,
                  fontSize: 115.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 100.h, bottom: 100.h),
              child: Text(
                "Sei sicuro di voler eliminare il tuo \naccount?",
                style: TextStyle(
                  fontFamily:
                      Theme.of(context).textTheme.displayMedium?.fontFamily,
                  color: Theme.of(context).textTheme.displayMedium?.color,
                  fontWeight: FontWeight.normal,
                  fontSize: 70.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.all(150.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WhiteButtonWidget(
                      testo: "Elimina", toggleCallback: handleCallback),
                  SizedBox(height: 100.w),
                  const CancelButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
