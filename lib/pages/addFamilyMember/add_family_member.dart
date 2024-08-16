import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/addFamilyMember/widget/add_family_member_button.dart';
import 'package:smartlinx/pages/addFamilyMember/widget/insert_member_field.dart';

import '../../services/hive.dart';

class AddFamilyMember extends StatefulWidget {
  Home home;
  AddFamilyMember({super.key, required this.home});

  @override
  State<AddFamilyMember> createState() => _AddFamilyMemberState();
}

class _AddFamilyMemberState extends State<AddFamilyMember> {
  final TextEditingController _emailController = TextEditingController();
  String errorCode = '';

  void refreshPage(String code) {
    setState(() {
      errorCode = code;
    });
  }

  @override
  Widget build(BuildContext context) {
    errorCode;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 110.w),
        child: Column(
          children: [
            SizedBox(height: 150.h),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              // Adjusted bottom padding
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Aggiungi membro",
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 120.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 75.h),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Inserisci email",
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
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 150.h, top: 100.h),
              child: InsertMember(
                controller: _emailController,
                hintText: "Inserisci Email",
              ),
            ),
            if (errorCode.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 0.h, left: 60.w),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber,
                          color: Colors.red,
                          size: 70.sp,
                        ),
                        SizedBox(
                          width: 45.w,
                        ),
                        Text(
                          errorCode,
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.fontFamily,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 62.sp,
                          ),
                        ),
                      ],
                    )),
              ),
            SizedBox(
              height: 1300.h,
            ),
            AddFamilyMemberButton(
              fieldController: _emailController,
              refreshPage: refreshPage,
              home: widget.home,
            ),
          ],
        ),
      ),
    );
  }
}
