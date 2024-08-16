import 'package:flutter/material.dart' as delete_account_popup;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartlinx/pages/selectLogin/selectlogin_page.dart';

import '../../../services/auth.dart';

class DeleteAccountPopup extends delete_account_popup.StatefulWidget {
  final void Function(int)? toggleCallback;

  const DeleteAccountPopup({super.key, required this.toggleCallback});

  @override
  delete_account_popup.State<DeleteAccountPopup> createState() => _IntroductionPopupState();
}

class _IntroductionPopupState extends delete_account_popup.State<DeleteAccountPopup> {
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  delete_account_popup.Widget build(delete_account_popup.BuildContext context) {
    return delete_account_popup.SafeArea(
      child: delete_account_popup.WillPopScope(
        onWillPop: () async {
          if (!_isDisposed) {
            setState(() {
              delete_account_popup.Navigator.of(context).pushAndRemoveUntil(
                delete_account_popup.MaterialPageRoute(
                  builder: (context) => const SelectLoginPage(),
                ),
                    (route) => false,
              );
            });
            Auth().signOut();
          }
          return false;
        },
        child: delete_account_popup.Container(
          width: double.infinity,
          height: delete_account_popup.MediaQuery.of(context).size.height * 0.5,
          padding: delete_account_popup.EdgeInsets.symmetric(horizontal: 20.w),
          child: delete_account_popup.SingleChildScrollView(
            child: delete_account_popup.Column(
              mainAxisAlignment: delete_account_popup.MainAxisAlignment.center,
              mainAxisSize: delete_account_popup.MainAxisSize.min,
              children: <delete_account_popup.Widget>[
                delete_account_popup.SizedBox(
                  height: 50.h,
                ),
                delete_account_popup.Text(
                  "Elimina Account",
                  style: delete_account_popup.TextStyle(
                    fontFamily:
                        delete_account_popup.Theme.of(context).textTheme.displayLarge?.fontFamily,
                    color: delete_account_popup.Theme.of(context).textTheme.displayLarge?.color,
                    fontWeight: delete_account_popup.FontWeight.w500,
                    fontSize: 110.sp,
                  ),
                  textAlign: delete_account_popup.TextAlign.center,
                ).animate().fade(duration: 700.ms, delay: 100.ms),
                delete_account_popup.SizedBox(
                  height: 70.h,
                ),
                delete_account_popup.Stack(
                  alignment: delete_account_popup.Alignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/Broken_heart.svg',
                      color: delete_account_popup.Theme.of(context)
                          .colorScheme
                          .secondaryContainer
                          .withOpacity(0.7),
                      height: 700.h,
                    ).animate().fade(duration: 700.ms, delay: 0.ms),
                  ],
                ),
                delete_account_popup.SizedBox(
                  height: 50.h,
                ),
                delete_account_popup.Text(
                  "Account eliminato con successo!",
                  style: delete_account_popup.TextStyle(
                    fontFamily:
                        delete_account_popup.Theme.of(context).textTheme.displayMedium?.fontFamily,
                    color: delete_account_popup.Theme.of(context).textTheme.displayMedium?.color,
                    fontWeight: delete_account_popup.FontWeight.normal,
                    fontSize: 75.sp,
                  ),
                  textAlign: delete_account_popup.TextAlign.center,
                ).animate().fade(duration: 700.ms, delay: 100.ms),
                delete_account_popup.SizedBox(
                  height: 100.h,
                ),
                delete_account_popup.Padding(
                  padding: delete_account_popup.EdgeInsets.symmetric(horizontal: 150.w),
                  child: delete_account_popup.Container(
                    width: 440.w,
                    height: 150.h,
                    decoration: delete_account_popup.BoxDecoration(
                      color: delete_account_popup.Theme.of(context).colorScheme.primary.withOpacity(0.4),
                      borderRadius: delete_account_popup.BorderRadius.circular(150.r),
                    ),
                    child: delete_account_popup.TextButton(
                      onPressed: () {
                        delete_account_popup.Navigator.of(context).pushAndRemoveUntil(
                          delete_account_popup.MaterialPageRoute(
                            builder: (context) => const SelectLoginPage(),
                          ),
                            (route) => false,
                        );
                      },
                      child: delete_account_popup.Text(
                        'Chiudi',
                        style: delete_account_popup.TextStyle(
                          fontFamily:
                          delete_account_popup.Theme.of(context).textTheme.displayLarge?.fontFamily,
                          fontWeight: delete_account_popup.FontWeight.normal,
                          fontSize: 60.sp,
                          color: delete_account_popup.Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  ),
                delete_account_popup.SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 400));
  }
}
