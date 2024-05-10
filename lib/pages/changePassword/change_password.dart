import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/changePassword/widget/appbar_change_password.dart';
import 'package:smartlinx/pages/changePassword/widget/change_password_button.dart';
import 'package:smartlinx/pages/changePassword/widget/change_password_field.dart';
import 'package:smartlinx/pages/selectLogin/selectlogin_page.dart';
import 'package:smartlinx/pages/sharedWidget/loading_animation.dart';
import '../../services/auth.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _controllerNuovaPassword =
      TextEditingController();
  final TextEditingController _controllerRipetiNuovaPassword =
      TextEditingController();
  String? _errorMessage;
  bool correctPassword = false;

  void changePassword() async {
    setState(() {
      _errorMessage = null;
      correctPassword = true;
    });

    LoadingAnimation loadingAnimation = LoadingAnimation(context);
    loadingAnimation.showLoading();

    bool isChanged =
        await Auth().changePassword(newPassword: _controllerNuovaPassword.text);

    if (isChanged) {
      setState(() {
        _errorMessage = null;
        correctPassword = true;
      });
      loadingAnimation.showFinal();
      await Future.delayed(const Duration(seconds: 2));
      Auth().signOut();
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                const SelectLoginPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
          (route) => false);
    } else {
      setState(() {
        loadingAnimation.dispose();
        _errorMessage = "Si è verificato un problema, riprova più tardi";
      });
    }
  }

  void _checkPasswords() async {
    String nuovaPassword = _controllerNuovaPassword.text;
    String ripetiNuovaPassword = _controllerRipetiNuovaPassword.text;

    if (nuovaPassword.isEmpty || ripetiNuovaPassword.isEmpty) {
      setState(() {
        _errorMessage = "Tutti i campi devono essere compilati";
        correctPassword = false;
      });
    } else if (nuovaPassword != ripetiNuovaPassword) {
      setState(() {
        _errorMessage = "Le 2 password non corrispondono";
        correctPassword = false;
      });
    } else if (nuovaPassword.length < 8) {
      setState(() {
        _errorMessage = "Password troppo debole";
        correctPassword = false;
      });
    } else {
      changePassword();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarChangePassword(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(110.w, 110.h, 110.w, 110.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Modifica password",
              style: TextStyle(
                fontFamily:
                    Theme.of(context).textTheme.displayLarge?.fontFamily,
                color: Theme.of(context).textTheme.displayLarge?.color,
                fontWeight: FontWeight.bold,
                fontSize: 120.sp,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 100.h,
            ),
            ChangePasswordField(
              controller: _controllerNuovaPassword,
              hintText: "Nuova password",
              titoloSuperiore: "Nuova password",
            ),
            SizedBox(
              height: 70.h,
            ),
            ChangePasswordField(
              controller: _controllerRipetiNuovaPassword,
              hintText: "Ripeti password",
              titoloSuperiore: "Conferma password",
            ),
            SizedBox(height: 120.h),
            if (_errorMessage != null)
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 80.sp,
                    ),
                    SizedBox(width: 40.w),
                    Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 55.sp,
                      ),
                    ),
                  ],
                ),
              ),
            const Spacer(),
            Center(
              child: CambiaPasswordButton(
                onPressed: () {
                  _checkPasswords();
                },
              ),
            ),
            SizedBox(
              height: 400.h,
            ),
          ],
        ),
      ),
    );
  }
}
