import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartlinx/pages/accountLoading/accountloading_page.dart';
import 'package:smartlinx/pages/loginPage/login_logic.dart';

import '../../../services/auth.dart';

class BottomSigninWidget extends StatefulWidget {

  Function showSnackBar;

  BottomSigninWidget({super.key, required this.showSnackBar});

  @override
  State<BottomSigninWidget> createState() => _BottomSigninWidgetState();
}

class _BottomSigninWidgetState extends State<BottomSigninWidget> {

  void redirectToLoadingUserPage(){
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
        const AccountLoadingPage(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
        (route)=> false
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            Text(
              'Oppure utilizza',
              style: TextStyle(
                fontSize: 55.sp,
                fontFamily:
                    Theme.of(context).textTheme.displayLarge?.fontFamily,
                color: Theme.of(context).textTheme.displayLarge?.color,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(
          height: 150.h,
        ),
        Row(
          children: [
            const Spacer(),
            Container(
              height: 210.h,
              width: 210.w,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () async {
                    if (await Auth().signInWithGoogle()) {
                      redirectToLoadingUserPage();
                    } else{
                      widget.showSnackBar('Si è verificato un problema, riprova più tardi.');
                    }
                  },
                  child: SvgPicture.asset(
                    'assets/svg/google.svg',
                    height: 140.h,
                    width: 140.w,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 60.w,
            ),
            GestureDetector(
              onTap: () async{
                if(await LoginLogic().signInWithFacebook()){
                  redirectToLoadingUserPage();
                } else{
                  widget.showSnackBar('Si è verificato un problema, riprova più tardi.');
                }
              },
              child: Container(
                height: 210.h,
                width: 210.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/svg/facebook.svg',
                    height: 140.h,
                    width: 140.w,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 60.w,
            ),
            Container(
              height: 210.h,
              width: 210.w,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/svg/apple.svg',
                  height: 140.h,
                  width: 140.w,
                  color: Theme.of(context).textTheme.displayLarge?.color,
                ),
              ),
            ),
            const Spacer(),
          ],
        )
      ],
    );
  }
}
