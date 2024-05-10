import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:smartlinx/pages/emailConfirm/emailconfirm_logic.dart';
import 'package:smartlinx/pages/emailConfirm/widget/confirm_wid.dart';

class EmailConfirm extends StatefulWidget {
  const EmailConfirm({super.key});

  @override
  State<EmailConfirm> createState() => _ConfermaMailState();
}

class _ConfermaMailState extends State<EmailConfirm>
    with SingleTickerProviderStateMixin {
  late AnimationController lottieController;

  @override
  void initState() {
    super.initState();
    EmailConfirmLogic().sendVerificationEmail();
    lottieController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    lottieController.forward();
  }

  void resendEmail() {
    EmailConfirmLogic().sendVerificationEmail();
    showSnackbar('Email di conferma inviata correttamente');
    lottieController.reset();
    lottieController.forward();
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
      backgroundColor: Theme.of(context).colorScheme.tertiary,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 400.h,
            ),
            Text(
              'Verifica indirizzo \nemail',
              style: TextStyle(
                fontFamily:
                    Theme.of(context).textTheme.displayLarge?.fontFamily,
                color: Theme.of(context).textTheme.displayLarge?.color,
                fontWeight: FontWeight.bold,
                fontSize: 120.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 70.h,
            ),
            Lottie.asset('assets/lottie/mail.json',
                height: 800.h, repeat: false, controller: lottieController),
            SizedBox(
              height: 120.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.w),
              child: Text(
                'Abbiamo appena inviato un link di verifica via email al tuo indirizzo. Controlla la tua casella di posta elettronica e clicca su quel link per verificare il tuo indirizzo email Se non vieni reindirizzato automaticamente dopo la verifica, clicca sul pulsante Continua.',
                style: TextStyle(
                  fontFamily:
                      Theme.of(context).textTheme.displayMedium?.fontFamily,
                  color: Theme.of(context).textTheme.displayMedium?.color,
                  fontWeight: FontWeight.normal,
                  fontSize: 60.sp,
                  letterSpacing: 0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 200.h,
            ),
            ConfirmWidget(showSnackBar: showSnackbar),
            SizedBox(
              height: 55.h,
            ),
            TextButton(
              onPressed: () {
                resendEmail();
              },
              child: Text(
                'invia di nuovo email',
                style: TextStyle(
                  fontFamily:
                      Theme.of(context).textTheme.displaySmall?.fontFamily,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 55.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
