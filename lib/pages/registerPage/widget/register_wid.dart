import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/emailConfirm/emailconfirm_page.dart';
import 'package:smartlinx/pages/registerPage/register_logic.dart';

class RegisterWidget extends StatefulWidget {
  final void Function(String)? showSnackBar;
  final TextEditingController? email;
  final TextEditingController? password;
  final TextEditingController? name;
  final TextEditingController? surname;
  final TextEditingController? confirmPassword;

  const RegisterWidget({
    super.key,
    required this.email,
    required this.password,
    this.confirmPassword,
    this.name,
    this.surname,
    this.showSnackBar,
  });

  @override
  RegisterWidgetState createState() => RegisterWidgetState();
}

class RegisterWidgetState extends State<RegisterWidget> {
  bool isLoading = false;

  void changeLoadingState(bool newValue) {
    setState(() {
      isLoading = newValue;
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
          if (await RegisterLogic().register(
            widget.email!.text,
            widget.password!.text,
            widget.confirmPassword!.text,
            widget.name!.text,
            widget.surname!.text,
            widget.showSnackBar!,
            changeLoadingState,
          )) {
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
        },
        child: (!isLoading)
            ? Text(
                'Registrati',
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
