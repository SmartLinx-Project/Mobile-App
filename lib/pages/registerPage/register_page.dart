import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: unused_import
import 'package:smartlinx/pages/emailConfirm/emailconfirm_logic.dart';
import 'package:smartlinx/pages/registerPage/widget/field_wid.dart';
import 'package:smartlinx/pages/registerPage/widget/password_field_wid.dart';
import 'package:smartlinx/pages/registerPage/widget/register_wid.dart';
import 'package:smartlinx/pages/selectLogin/selectlogin_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cognomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confermaPasswordController =
      TextEditingController();
  final FocusNode _nomeFocus = FocusNode();
  final FocusNode _cognomeFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confermaPasswordFocus = FocusNode();

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
      backgroundColor: Theme.of(context).colorScheme.tertiary,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void requestFocusField(int field) {
    switch (field) {
      case 1:
        _cognomeFocus.requestFocus();
        break;
      case 2:
        _emailFocus.requestFocus();
        break;
      case 3:
        _passwordFocus.requestFocus();
        break;
      case 4:
        _confermaPasswordFocus.requestFocus();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(
                  height: 60.h,
                ),
                Text('Benvenuto!',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge?.color,
                      fontSize: 140.sp,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 100.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Text(
                    'Manca poco! dopo la registrazione potrai usufruire di tutte le funzionalità che abbiamo pensato per rendere la tua casa più automatica e intelligente',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.displayMedium?.color,
                      fontSize: 60.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 200.h,
                ),
                FieldWidget(
                  controller: _nomeController,
                  focusNode: _nomeFocus,
                  onSubmitted: requestFocusField,
                  hintText: 'Nome',
                ),
                SizedBox(
                  height: 70.h,
                ),
                FieldWidget(
                  controller: _cognomeController,
                  focusNode: _cognomeFocus,
                  onSubmitted: requestFocusField,
                  hintText: 'Cognome',
                ),
                SizedBox(
                  height: 70.h,
                ),
                FieldWidget(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  onSubmitted: requestFocusField,
                  hintText: 'Email',
                ),
                SizedBox(
                  height: 70.h,
                ),
                PasswordFieldWidget(
                  controller: _passwordController,
                  hintText: 'Password',
                  focusNode: _passwordFocus,
                  onSubmitted: requestFocusField,
                ),
                SizedBox(
                  height: 70.h,
                ),
                PasswordFieldWidget(
                  controller: _confermaPasswordController,
                  hintText: 'Conferma password',
                  focusNode: _confermaPasswordFocus,
                  onSubmitted: requestFocusField,
                ),
                SizedBox(
                  height: 150.h,
                ),
                RegisterWidget(
                  password: _passwordController,
                  email: _emailController,
                  showSnackBar: showSnackbar,
                  name: _nomeController,
                  surname: _cognomeController,
                  confirmPassword: _confermaPasswordController,
                ),
              ],
            ),
          ),
        ),
      ).animate().fade(duration: 400.ms, delay: 0.ms),
    );
  }
}
