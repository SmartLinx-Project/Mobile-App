import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/accountPage/widget/app_bar_account_wid.dart';
import 'package:smartlinx/pages/accountPage/widget/handle_users_widget.dart';
import 'package:smartlinx/pages/accountPage/widget/elimina_account_wid.dart';
import 'package:smartlinx/pages/sharedWidget/bottomnavbar_wid.dart';
import 'package:smartlinx/services/auth.dart';
import 'package:smartlinx/services/google_storage.dart';
import 'package:smartlinx/services/userdata.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String firstName = UserData.instance.getFirstName()!;
  String lastName = UserData.instance.getLastName()!;
  String email = UserData.instance.getEmail()!;
  bool isLoggedWithGoogle = false;

  @override
  void initState() {
    super.initState();
    cacheImage();
  }

  void cacheImage() {
    String? photoUrl = Auth().getProfilePhotoUrl();
    if (photoUrl != null) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const BotNavBarWidget(
        index: 4,
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarAccountInfo(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 150.h),
            Stack(
              children: [
                if (Auth().getProfilePhotoUrl() == null)
                  Image(
                    image: const AssetImage("assets/images/generic_user.png"),
                    width: 650.w,
                  )
                else
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: Auth().getProfilePhotoUrl()!,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: 650.w,
                      height: 650.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                Positioned(
                    top: 500.h,
                    left: 500.h,
                    child: GestureDetector(
                      onTap: () async {
                        await GoogleStorage().pickUploadImage();
                        setState(() {});
                      },
                      child: Container(
                        height: 130.h,
                        width: 130.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.edit,
                            size: 80.sp,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            SizedBox(height: 150.h),
            Text(
              'Bentornato $firstName',
              style: TextStyle(
                fontFamily:
                    Theme.of(context).textTheme.displayLarge?.fontFamily,
                color: Theme.of(context).textTheme.displayLarge?.color,
                fontWeight: FontWeight.bold,
                fontSize: 100.sp,
              ),
            ),
            SizedBox(height: 150.h),
            HandleUserButton(
              firstName: firstName,
              lastName: lastName,
              email: email,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 150.h),
                  child: const DeleteAccountButton(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
