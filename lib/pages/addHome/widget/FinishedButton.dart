import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/endAddHome/endaddhome.dart';
import 'package:smartlinx/pages/sharedWidget/loading_animation.dart';
import 'package:smartlinx/services/http.dart';
import 'package:smartlinx/services/init_app.dart';

class FinishedButton extends StatefulWidget {
  TextEditingController nameController;
  TextEditingController addressController;
  FinishedButton({super.key, required this.nameController, required this.addressController});

  @override
  State<FinishedButton> createState() => _FinishedButtonState();
}

class _FinishedButtonState extends State<FinishedButton> {

  void addHome() async{
    String name = widget.nameController.text;
    String address = widget.addressController.text;
    LoadingAnimation loadingAnimation = LoadingAnimation(context);
    loadingAnimation.showLoading();
    if(await HttpService().addHome(name: name, address: address)){
      await InitApp().startInit();
      loadingAnimation.showFinal();
      await Future.delayed(const Duration(seconds: 2));
      loadingAnimation.dispose();
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
          const EndAddHome(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
              (route)=> false
      );
    } else{
      loadingAnimation.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.w,
      height: 200.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(150.r),
      ),
      child: TextButton(
        onPressed: () {
          addHome();
        },
        child: Text(
          'Aggiungi',
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 65.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
