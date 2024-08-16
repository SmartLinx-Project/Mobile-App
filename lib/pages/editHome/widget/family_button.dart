import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/services/hiveMethod/userdata_hive.dart';

import '../../../services/hive.dart';
import '../../showMembriFamiglia/show_family_member.dart';

class HandleHomeFamilyButton extends StatefulWidget {
  final String text;
  final Home home;
  const HandleHomeFamilyButton({super.key, required this.text, required this.home});

  @override
  State<HandleHomeFamilyButton> createState() => _HandleHomeFamilyButtonState();
}

class _HandleHomeFamilyButtonState extends State<HandleHomeFamilyButton> {
  late String text;
  late int membersNumber;

  @override
  void initState() {
    super.initState();
    text = widget.text;
    List<FamilyMember> familyMembers = FamilyMembersHive.instance
        .getFamilyMembersFromHomeID(widget.home.homeID);
    membersNumber = familyMembers.length;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => ShowFamilyMember(
              home: widget.home,
              currentHome: widget.home.homeID,
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      child: Container(
        height: 180.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 2.5,
          ),
          color: Theme.of(context).bottomSheetTheme.backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 50.w),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 60.sp,
                  color: Theme.of(context).textTheme.displayLarge!.color,
                  fontFamily:
                      Theme.of(context).textTheme.displayLarge!.fontFamily,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Text(
              membersNumber.toString(),
              style: TextStyle(
                fontSize: 60.sp,
                color: Theme.of(context).textTheme.displayMedium!.color,
                fontFamily:
                    Theme.of(context).textTheme.displayMedium!.fontFamily,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: 60.w,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color!.withOpacity(0.8),
            ),
            SizedBox(
              width: 50.w,
            ),
          ],
        ),
      ),
    );
  }
}
