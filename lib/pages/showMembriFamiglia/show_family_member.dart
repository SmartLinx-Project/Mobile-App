import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/showMembriFamiglia/widget/appbar_wid.dart';
import 'package:smartlinx/pages/showMembriFamiglia/widget/finished_button.dart';
import 'package:smartlinx/pages/showMembriFamiglia/widget/user_grid_widget.dart';
import 'package:smartlinx/pages/homePage/home_page.dart';
import '../../services/hive.dart';
import '../addFamilyMember/add_family_member.dart';

class ShowFamilyMember extends StatefulWidget {
  final Home home;
  final int? currentHome;
  const ShowFamilyMember({super.key, required this.home, this.currentHome});

  @override
  State<ShowFamilyMember> createState() => _ShowFamilyMemberState();
}

class _ShowFamilyMemberState extends State<ShowFamilyMember> {
  bool owner = false;

  @override
  void initState() {
    super.initState();
    owner = widget.home.isOwner;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        owner: owner,
        onBack: () {
          if (widget.currentHome == null) {
            Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    const HomePage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
              (route) => false,
            );
          } else {
            Navigator.pop(context);
          }
        },
        onAdd: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  AddFamilyMember(home: widget.home),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 110.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Membri Famiglia",
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 130.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Gestisci chi può accedere alla tua casa",
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
              ),
              SizedBox(
                height: 150.h,
              ),
              UserGridWidget(
                home: widget.home,
              ),
              SizedBox(height: 250.h),
              Center(
                child: FinishedButtonWidget(
                  currentHome: widget.currentHome,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
