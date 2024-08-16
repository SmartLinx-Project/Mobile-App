import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/services/hive.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/hiveMethod/userdata_hive.dart';
import '../../showMembriFamiglia/show_family_member.dart';

class FamilyMemberWidget extends StatelessWidget {
  final Home home;
  FamilyMemberWidget({super.key, required this.home});

  final List<FamilyMemberPhotoUrlObject> profileImageUrl = [];

  void handleFamilyMembersImage() {
    int padding = 0;
    List<FamilyMember> members = FamilyMembersHive.instance
        .getFamilyMembersFromHomeID(HomeHive.instance.getCurrentHome()!);
    for (int i = 0; i < members.length && i < 4; i++) {
      if (members[i].photoUri != '') {
        profileImageUrl
            .add(FamilyMemberPhotoUrlObject(members[i].photoUri, padding));
      } else {
        profileImageUrl.add(FamilyMemberPhotoUrlObject(
            'assets/images/generic_user.png', padding));
      }
      padding += 90;
    }
  }

  @override
  Widget build(BuildContext context) {
    handleFamilyMembersImage();
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => ShowFamilyMember(
              home: home,
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      child: Row(
        children: [
          Text(
            "Membri Famiglia",
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
              color: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.color!
                  .withOpacity(0.8),
              fontWeight: FontWeight.bold,
              fontSize: 90.sp,
            ),
            textAlign: TextAlign.left,
          ),
          const Spacer(),
          Stack(
            children: [
              for (var imageUrl in profileImageUrl)
                (imageUrl.url == 'assets/images/generic_user.png')
                    ? Padding(
                        padding: EdgeInsets.only(left: imageUrl.padding.w),
                        child: ClipOval(
                          child: Image.asset(imageUrl.url, height: 120.h),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(left: imageUrl.padding.w),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: imageUrl.url,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            width: 120.h,
                            height: 120.h,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
            ],
          ),
        ],
      ),
    );
  }
}

class FamilyMemberPhotoUrlObject {
  String url = '';
  int padding = 0;

  FamilyMemberPhotoUrlObject(this.url, this.padding);
}
