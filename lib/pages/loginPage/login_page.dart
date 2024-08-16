import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/loginPage/widget/bottomsignin_wid.dart';
import 'package:smartlinx/pages/loginPage/widget/field_pass_wid.dart';
import 'package:smartlinx/pages/loginPage/widget/field_wid.dart';
import 'package:smartlinx/pages/loginPage/widget/login_wid.dart';

import '../../services/auth.dart';
import '../selectLogin/selectlogin_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode passwordFocus = FocusNode();

  void resetPassword() async {
    String email = _emailController.text;
    if (email.isNotEmpty) {
      if (await Auth().resetPassword(_emailController.text)) {
        showSnackbar('Email di rispritino password inviata con successo');
      } else {
        showSnackbar('Impossibile inviare email di ripristino password');
      }
    } else {
      showSnackbar('Il campo email non può essere vuoto');
    }
  }

  void showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
            fontSize: 55.sp,
            color: Theme.of(context).textTheme.displayMedium?.color),
        textAlign: TextAlign.left,
      ),
      duration: const Duration(milliseconds: 2500),
      backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void onEmailSubmitted() {
    passwordFocus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    const SelectLoginPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100.w),
          child: Center(
            child: Column(
              children: [
                Text('Bentornato!',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge?.color,
                      fontSize: 120.sp,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 90.h,
                ),
                Text(
                  'Accedi per visualizzare e gestire la tua casa in modo facile, veloce e intuitivo',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayMedium?.color,
                    fontSize: 60.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.8,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 230.h,
                ),
                FieldWidget(
                  controller: _emailController,
                  hintText: 'Email',
                  onSubmitted: onEmailSubmitted,
                ),
                SizedBox(
                  height: 60.h,
                ),
                FieldPassWidget(
                    controller: _passwordController,
                    hintText: 'Password',
                    focusNode: passwordFocus),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      resetPassword();
                    },
                    child: Text(
                      'Password Dimenticata?',
                      style: TextStyle(
                        fontFamily: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.fontFamily,
                        color: Theme.of(context).textTheme.displayLarge?.color,
                        fontWeight: FontWeight.w500,
                        fontSize: 60.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100.h,
                ),
                LoginWidget(
                  showSnackBar: showSnackbar,
                  email: _emailController,
                  password: _passwordController,
                ),
                SizedBox(
                  height: 200.h,
                ),
                BottomSigninWidget(showSnackBar: showSnackbar,),
              ],
            ),
          ),
        ),
      ).animate().fade(duration: 400.ms, delay: 0.ms),
    );
  }
}
