import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../services/hive.dart';
import '../../../services/hiveMethod/userdata_hive.dart';
import 'memberrow_wid.dart';

class UserGridWidget extends StatefulWidget {
  final Home home;
  const UserGridWidget({super.key, required this.home});

  @override
  State<UserGridWidget> createState() => _UserGridWidgetState();
}

class _UserGridWidgetState extends State<UserGridWidget> {
  final List<Widget> _membersWidget = [];
  List<FamilyMember> familyMembers = [];

  @override
  void initState() {
    super.initState();
    familyMembers = FamilyMembersHive.instance
        .getFamilyMembersFromHomeID(widget.home.homeID);
    _addMembers();
  }

  void _addMembers() {
    for (int i = 0; i < familyMembers.length; i++) {
      _membersWidget.add(
        Column(
          children: [
            MemberRowWidget(
              familyMembers: familyMembers[i],
            ),
            SizedBox(height: 50.h),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(80.r),
      ),
      height: 1550.h,
      width: 2900.h,
      child: Padding(
        padding: EdgeInsets.all(100.h),
        child: (familyMembers.isNotEmpty)
            ? ListView(
                children: _membersWidget,
              )
            : Center(
                child: Text(
                  "Nessun membro famiglia",
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.displayMedium?.fontFamily,
                    color: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.color!
                        .withOpacity(1),
                    fontWeight: FontWeight.normal,
                    fontSize: 63.sp,
                  ),
                ),
              ),
      ),
    );
  }
}
