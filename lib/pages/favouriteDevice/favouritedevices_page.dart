import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/favouriteDevice/widget/havefavourite_wid.dart';
import 'package:smartlinx/pages/favouriteDevice/widget/notfavourite_wid.dart';
import 'package:smartlinx/pages/sharedWidget/bottomnavbar_wid.dart';
import 'package:smartlinx/services/hive.dart';
import 'package:smartlinx/services/hiveMethod/favourite_hive.dart';

class FavouriteDevicePage extends StatefulWidget {
  const FavouriteDevicePage({super.key});

  @override
  State<FavouriteDevicePage> createState() => _FavouriteDevicePageState();
}

class _FavouriteDevicePageState extends State<FavouriteDevicePage> {
  bool haveFavouriteDevice = true;

  void checkIfHaveFavourite(){

    List<Favourite> favourites = FavouriteHive.instance.getAllFavourite();
    if(favourites.isNotEmpty){
      haveFavouriteDevice = true;
    }
    else{
      haveFavouriteDevice = false;
    }
  }

  void refreshPage() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkIfHaveFavourite();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: const BotNavBarWidget(
        index: 1,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            right: 110.w, left: 110.w, bottom: 100.h, top: 400.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preferiti',
              style: TextStyle(
                color: Theme.of(context).textTheme.displayLarge?.color,
                fontFamily:
                Theme.of(context).textTheme.displayLarge?.fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 130.sp,
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            Expanded(
              child: (haveFavouriteDevice)
                  ? HaveFavouriteDeviceWidget(refreshPage: refreshPage,)
                  : const NotFavouriteDeviceWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
