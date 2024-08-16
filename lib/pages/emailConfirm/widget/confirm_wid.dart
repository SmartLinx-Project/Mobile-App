import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/emailConfirm/emailconfirm_logic.dart';
import 'package:smartlinx/pages/loginPage/login_page.dart';

class ConfirmWidget extends StatefulWidget {
  final void Function(String)? showSnackBar;

  const ConfirmWidget({super.key, required this.showSnackBar});

  @override
  ConfirmWidgetState createState() => ConfirmWidgetState();
}

class ConfirmWidgetState extends State<ConfirmWidget> {
  bool isLoading = false;

  void changeLoadingState(bool newValue) {
    setState(() {
      isLoading = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800.w,
      height: 200.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 3),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextButton(
        onPressed: () async {
          if (await EmailConfirmLogic().checkVerification(changeLoadingState)) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
              (route) => false, // Rimuove tutte le pagine precedenti
            );
          } else {
            widget.showSnackBar!(
                'La tua email non è ancora stata verificata, clicca sul link che ti abbiamo mandato');
          }
        },
        child: (!isLoading)
            ? Text(
                'Verifica',
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
