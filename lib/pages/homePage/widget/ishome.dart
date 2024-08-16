import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/homePage/widget/homedropmenu_wid.dart';
import 'package:smartlinx/pages/homePage/widget/waveclipper.dart';
import 'package:smartlinx/pages/homePage/widget/weathercontainer_wid.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import '../../../services/hive.dart';
import '../../../services/userdata.dart';
import 'familymember_wid.dart';

class IsHomeWidget extends StatefulWidget {
  const IsHomeWidget({super.key});

  @override
  State<IsHomeWidget> createState() => _IsHomeWidgetState();
}

class _IsHomeWidgetState extends State<IsHomeWidget> {
  String firstName = UserData.instance.getFirstName()!;
  String lastName = UserData.instance.getLastName()!;
  List<Home> homes = HomeHive.instance.getAllHomes();

  void refreshPage() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            height: 2750.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 100.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 400.h,
              ),
              Text(
                "Buongiorno!",
                style: TextStyle(
                  fontFamily:
                      Theme.of(context).textTheme.displayLarge?.fontFamily,
                  color: Theme.of(context).textTheme.displayLarge?.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 130.sp,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                '$firstName $lastName',
                style: TextStyle(
                  fontFamily:
                      Theme.of(context).textTheme.displayMedium?.fontFamily,
                  color: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.color!
                      .withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                  fontSize: 65.sp,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 150.h,
              ),
              Row(
                children: [
                  Text(
                    'Abitazione',
                    style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.displayLarge?.fontFamily,
                      color: Theme.of(context).textTheme.displayLarge?.color,
                      fontSize: 70.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  HomeDropMenu(
                    refreshPageCallback: refreshPage,
                  ),
                ],
              ),
              SizedBox(
                height: 150.h,
              ),
              WeatherContainerWidget(),
              SizedBox(
                height: 420.h,
              ),
              FamilyMemberWidget(
                home: HomeHive.instance
                    .getHomeFromID(HomeHive.instance.getCurrentHome()!),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
