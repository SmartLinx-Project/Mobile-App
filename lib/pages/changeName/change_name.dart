import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/accountPage/account_page.dart';
import 'package:smartlinx/pages/changeName/widget/edit_name_button.dart';
import 'package:smartlinx/services/userdata.dart';
import '../sharedWidget/loading_animation.dart';
import 'widget/appbar_change_name.dart';
import 'widget/edit_name_field.dart';

class ChangeAccountName extends StatefulWidget {
  const ChangeAccountName({super.key});

  @override
  State<ChangeAccountName> createState() => _ChangeAccountNameState();
}

class _ChangeAccountNameState extends State<ChangeAccountName> {
  late final TextEditingController _newNameController = TextEditingController();
  late final TextEditingController _newSurNameController =
      TextEditingController();
  String errorMessage = '';

  void editErrorMessage(String message){
    setState(() {
      errorMessage = message;
    });
  }

  Future<void> editName() async {
    if (_newNameController.text.isNotEmpty &&
        _newSurNameController.text.isNotEmpty) {
      errorMessage = '';
      LoadingAnimation loadingAnimation = LoadingAnimation(context);
      loadingAnimation.showLoading();
      if (await UserData()
          .editName(_newNameController.text, _newSurNameController.text)) {
        loadingAnimation.showFinal();
        await Future.delayed(const Duration(seconds: 2));

        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                const AccountPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
          (route) => false,
        );
      } else {
        loadingAnimation.dispose();
        setState(() {
          errorMessage = 'Si è verificato un errore';
        });
      }
    } else{
      setState(() {
        errorMessage = 'Tutti i campi devono essere compilati!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const edit_name_field(),
      body: Padding(
        padding: EdgeInsets.all(100.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Modifica Nome",
              style: TextStyle(
                fontFamily:
                    Theme.of(context).textTheme.displayLarge?.fontFamily,
                color: Theme.of(context).textTheme.displayLarge?.color,
                fontWeight: FontWeight.bold,
                fontSize: 115.sp,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 150.h),
            Text(
              "Nuovo nome",
              style: TextStyle(
                fontFamily:
                    Theme.of(context).textTheme.displayMedium?.fontFamily,
                color: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.color!
                    .withOpacity(1),
                fontWeight: FontWeight.w500,
                fontSize: 65.sp,
              ),
            ),
            SizedBox(height: 75.h),
            EditNameField(
              controller: _newNameController,
              hintText: "Inserisci Nome",
            ),
            SizedBox(height: 120.h),
            Text(
              "Nuovo Cognome",
              style: TextStyle(
                fontFamily:
                    Theme.of(context).textTheme.displayMedium?.fontFamily,
                color: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.color!
                    .withOpacity(1),
                fontWeight: FontWeight.w500,
                fontSize: 60.sp,
              ),
            ),
            SizedBox(height: 75.h),
            EditNameField(
              controller: _newSurNameController,
              hintText: "Inserisci Cognome",
            ),
            SizedBox(
              height: 90.h,
            ),
            if (errorMessage.isNotEmpty)
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
                      errorMessage,
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
              child: EditNameButton(
                onPressed: () {
                  editName();
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
