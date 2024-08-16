import 'package:flutter/material.dart' as add_family_member;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/sharedWidget/loading_animation.dart';
import 'package:smartlinx/pages/showMembriFamiglia/show_family_member.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/http.dart';
import 'package:smartlinx/services/init_app.dart';

import '../../../services/hive.dart';

class AddFamilyMemberButton extends add_family_member.StatefulWidget {
  add_family_member.TextEditingController fieldController;
  Function refreshPage;
  Home home;
  AddFamilyMemberButton(
      {super.key,
      required this.fieldController,
      required this.refreshPage,
      required this.home});

  @override
  add_family_member.State<AddFamilyMemberButton> createState() =>
      _LoginWidgetState();
}

class _LoginWidgetState extends add_family_member.State<AddFamilyMemberButton> {
  void addMember() async {
    String mail = widget.fieldController.text;
    int homeID = HomeHive.instance.currentHome!;
    LoadingAnimation loadingAnimation = LoadingAnimation(context);
    loadingAnimation.showLoading();
    int result =
        await HttpService().addFamilyMember(homeID: homeID, mail: mail.trim());
    String errorCode = '';
    if (result == 0) {
      await InitApp().startInit();
      loadingAnimation.showFinal();
      widget.refreshPage('');
      await Future.delayed(const Duration(seconds: 2));
      loadingAnimation.dispose();
      redirectToPage();
    } else if (result == 1) {
      loadingAnimation.dispose();
      errorCode = 'Hai già aggiunto questo utente!';
      widget.refreshPage(errorCode);
    } else if (result == 2) {
      loadingAnimation.dispose();
      errorCode = 'Questo utente non esiste!';
      widget.refreshPage(errorCode);
    } else if (result == 3) {
      loadingAnimation.dispose();
      errorCode = 'Errore, riprova più tardi';
      widget.refreshPage(errorCode);
    }
  }

  void redirectToPage() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            ShowFamilyMember(home: widget.home),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  add_family_member.Widget build(add_family_member.BuildContext context) {
    return add_family_member.Container(
      width: 400.w,
      height: 160.h,
      decoration: add_family_member.BoxDecoration(
        color: add_family_member.Theme.of(context).colorScheme.primary,
        borderRadius: add_family_member.BorderRadius.circular(120.r),
      ),
      child: add_family_member.TextButton(
        onPressed: () {
          addMember();
        },
        child: add_family_member.Text(
          'Aggiungi',
          style: add_family_member.TextStyle(
            fontFamily: add_family_member.Theme.of(context)
                .textTheme
                .displayLarge
                ?.fontFamily,
            fontWeight: add_family_member.FontWeight.normal,
            fontSize: 60.sp,
            color: add_family_member.Colors.white,
          ),
        ),
      ),
    );
  }
}
