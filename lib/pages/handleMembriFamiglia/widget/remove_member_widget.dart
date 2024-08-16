import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/sharedWidget/loading_animation.dart';
import 'package:smartlinx/pages/showMembriFamiglia/show_family_member.dart';
import 'package:smartlinx/services/hive.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/hiveMethod/userdata_hive.dart';
import 'package:smartlinx/services/http.dart';

class RemoveMemberButton extends StatefulWidget {
  final FamilyMember member;

  const RemoveMemberButton({super.key, required this.member});

  @override
  State<RemoveMemberButton> createState() => _RemoveMemberButtonState();
}

class _RemoveMemberButtonState extends State<RemoveMemberButton> {
  void redirectToShowMemberPage() {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => ShowFamilyMember(
          home: HomeHive.instance.getHomeFromID(widget.member.homeID),
        ),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000.w,
      height: 200.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(90.r),
      ),
      child: TextButton(
        onPressed: () async {
          LoadingAnimation loadingAnimation = LoadingAnimation(context);
          loadingAnimation.showLoading();
          if (await HttpService().delFamilyMember(
              homeID: widget.member.homeID, mail: widget.member.email)) {
            FamilyMembersHive.instance.deleteUser(widget.member.email);
            loadingAnimation.showFinal();
            await Future.delayed(const Duration(seconds: 2));
            redirectToShowMemberPage();
          } else {
            loadingAnimation.dispose();
          }
        },
        child: Text(
          'Rimuovi Membro',
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 68.sp,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
