import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/handleMembriFamiglia/handle_family_member.dart';

import '../../../services/hive.dart';

class MemberRowWidget extends StatefulWidget {

  final FamilyMember familyMembers;

  const MemberRowWidget({super.key, required this.familyMembers});

  @override
  State<MemberRowWidget> createState() => _MemberRowWidgetState();
}

class _MemberRowWidgetState extends State<MemberRowWidget> {

  late String _name;

  @override
  void initState() {
    super.initState();
    _name = '${widget.familyMembers.firstName} ${widget.familyMembers.lastName}';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => HandleFamilyMember(familyMember: widget.familyMembers,),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );

      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _name,
                style: TextStyle(
                  fontFamily: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.fontFamily,
                  color: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.color!
                      .withOpacity(0.9),
                  fontSize: 60.sp,
                ),
              ),
              Icon(
                Icons.menu,
                color: Theme.of(context).textTheme.displayLarge?.color,
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Divider(
            thickness: 1.0,
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
