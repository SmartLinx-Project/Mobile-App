import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/handleMembriFamiglia/widget/remove_member_widget.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';

import '../../services/hive.dart';

class HandleFamilyMember extends StatefulWidget {
  final FamilyMember familyMember;

  const HandleFamilyMember({super.key, required this.familyMember});

  @override
  State<HandleFamilyMember> createState() => _HandleFamilyMemberState();
}

class _HandleFamilyMemberState extends State<HandleFamilyMember> {
  late String _name;
  late String _email;
  late Widget photoProfile;
  bool owner = false;

  void getFamilyMemberPhotoProfile() {
    String photoUrl = widget.familyMember.photoUri;
    if (photoUrl != '') {
      photoProfile = ClipOval(
        child: CachedNetworkImage(
          imageUrl: photoUrl,
          placeholder: (context, url) =>
          const CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
          const Icon(Icons.error),
          width: 650.w,
          height: 650.w,
          fit: BoxFit.cover,
        ),
      );
    } else {
      photoProfile = Image(
        image: const AssetImage("assets/images/generic_user.png"),
        width: 650.w,
      );
    }
  }

  void checkOwner() {
    int homeID = widget.familyMember.homeID;
    Home home = HomeHive.instance.getHomeFromID(homeID);
    if (home.isOwner) {
      owner = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _name = '${widget.familyMember.firstName} ${widget.familyMember.lastName}';
    _email = widget.familyMember.email;
    getFamilyMemberPhotoProfile();
    checkOwner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestisci Membro"),
        titleTextStyle: TextStyle(
          fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
          color: Theme.of(context).textTheme.displayLarge?.color,
          fontWeight: FontWeight.normal,
          fontSize: 70.sp,
        ),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 150.h,
            ),
            photoProfile,
            SizedBox(height: 150.h),
            Text(
              "Informazioni Membro",
              style: TextStyle(
                fontFamily:
                    Theme.of(context).textTheme.displayLarge?.fontFamily,
                color: Theme.of(context).textTheme.displayLarge?.color,
                fontWeight: FontWeight.bold,
                fontSize: 100.sp,
              ),
            ),
            SizedBox(height: 150.h),
            Padding(
              padding: EdgeInsets.only(left: 240.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_circle,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      SizedBox(width: 70.w),
                      Text(
                        _name,
                        style: TextStyle(
                          fontFamily: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.fontFamily,
                          color:
                              Theme.of(context).textTheme.displayMedium?.color,
                          fontSize: 65.sp,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: 100.w),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mail_outline,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      SizedBox(width: 70.w),
                      Text(
                        (_email.length <= 30) ? _email : '${_email.substring(0, 30)}...',
                        style: TextStyle(
                          fontFamily: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.fontFamily,
                          color:
                              Theme.of(context).textTheme.displayMedium?.color,
                          fontSize: 65.sp,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
            (owner)
                ? Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 300.h),
                        child: RemoveMemberButton(
                          member: widget.familyMember,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
