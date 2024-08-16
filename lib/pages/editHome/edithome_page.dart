import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartlinx/pages/editHome/widget/appbar.dart';
import 'package:smartlinx/pages/editHome/widget/confirm_buttons.dart';
import 'package:smartlinx/pages/editHome/widget/family_button.dart';
import 'package:smartlinx/pages/editHome/widget/field.dart';
import 'package:smartlinx/pages/editHome/widget/home_button.dart';
import 'package:smartlinx/pages/handleHomes/handle_homes.dart';
import 'package:smartlinx/pages/sharedWidget/loading_animation.dart';
import 'package:smartlinx/services/http.dart';
import 'package:smartlinx/services/init_app.dart';

import '../../services/hive.dart';

class EditHomePage extends StatefulWidget {
  final Home home;
  const EditHomePage({super.key, required this.home});

  @override
  State<EditHomePage> createState() => _EditHomePageState();
}

class _EditHomePageState extends State<EditHomePage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.home.name;
    addressController.text = widget.home.address;
  }

  void editHome() async{
    if(nameController.text.isNotEmpty && addressController.text.isNotEmpty){
      LoadingAnimation loadingAnimation = LoadingAnimation(context);
      loadingAnimation.showLoading();
      if(await HttpService().setHome(homeID: widget.home.homeID, name: nameController.text, address: addressController.text)){
        await InitApp().startInit();
        loadingAnimation.showFinal();
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
            const HandleHomes(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      } else{
        loadingAnimation.dispose();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarEditHome(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Stack(
            children: [
              Positioned(
                top: 950.h,
                left: 400.h,
                child: SvgPicture.asset('assets/svg/house.svg', height: 1500.h),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 250.h,
                    ),
                    HandleHomeField(text: 'Nome', controller: nameController,),
                    SizedBox(
                      height: 100.h,
                    ),
                    HandleHomeField(text: 'Indirizzo', controller: addressController,),
                    SizedBox(
                      height: 100.h,
                    ),
                    HandleHomeRoomButton(text: 'Stanze', home: widget.home,),
                    SizedBox(
                      height: 100.h,
                    ),
                    HandleHomeFamilyButton(text: 'Membri Famiglia', home: widget.home,),
                    SizedBox(
                      height: 1200.h,
                    ),
                    HandleHomeConfirmButtons(editHome: editHome, home: widget.home,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
