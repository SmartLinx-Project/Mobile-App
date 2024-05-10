import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/devicePage/widget/try_again_button.dart';

class HubOfflineWidget extends StatelessWidget {
  final Function refreshPage;
  const HubOfflineWidget({super.key, required this.refreshPage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 400.h,
          ),
          Text(
            'Attenzione! il tuo Hub non è attualmente connesso, verifica che sia correttamente installato e funzionante',
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.displayMedium?.fontFamily,
              color: Theme.of(context).textTheme.displayMedium?.color,
              fontWeight: FontWeight.normal,
              fontSize: 70.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 120.h,
          ),
          Image.asset(
            'assets/images/hub-offline.png',
            height: 500.h,
          ),
          SizedBox(
            height: 300.h,
          ),
          TryAgainWidget(
            refreshPage: refreshPage,
          ),
        ],
      ),
    );
  }
}
