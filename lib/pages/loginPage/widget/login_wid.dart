import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/accountLoading/accountloading_page.dart';
import 'package:smartlinx/pages/emailConfirm/emailconfirm_page.dart';
import 'package:smartlinx/pages/loginPage/login_logic.dart';

class LoginWidget extends StatefulWidget {
  final void Function(String)? showSnackBar;
  final TextEditingController? email;
  final TextEditingController? password;

  const LoginWidget({super.key, this.email, this.password, this.showSnackBar});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool isLoading = false;

  void _goToPage() {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => const AccountLoadingPage(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
          (route) => false, // Rimuove tutte le pagine precedenti
    );
  }

  void changeLoadingState(bool newState){
    setState(() {
      isLoading = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: () async {
          FocusScope.of(context).unfocus();
          if (await LoginLogic().login(widget.email!.text.trim(),
              widget.password!.text, widget.showSnackBar!, changeLoadingState,)) {
            if (await LoginLogic().checkVerification(changeLoadingState)) {
              _goToPage();
            } else {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const EmailConfirm(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            }
          }
        },
        child: (!isLoading)
            ? Text(
                'Login',
                style: TextStyle(
                  fontFamily:
                      Theme.of(context).textTheme.displayLarge?.fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 80.sp,
                  color: Colors.white,
                ),
              )
            : const CircularProgressIndicator(
                color: Colors.white,
              ),
      ),
    );
  }
}
