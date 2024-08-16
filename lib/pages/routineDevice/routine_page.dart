import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/newRoutine/selDevicePage.dart';
import 'package:smartlinx/pages/routineDevice/widget/routine_wid.dart';
import 'package:smartlinx/pages/routineDevice/widget/notroutine_wid.dart';
import 'package:smartlinx/pages/sharedWidget/bottomnavbar_wid.dart';
import 'package:smartlinx/services/hive.dart';
import 'package:smartlinx/services/hiveMethod/favourite_hive.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  bool haveFavouriteDevice = true;

  void checkIfHaveRoutines() {
    List<Favourite> favourites = FavouriteHive.instance.getAllFavourite();
    if (favourites.isNotEmpty) {
      haveFavouriteDevice = true;
    } else {
      haveFavouriteDevice = false;
    }
  }

  bool checkIfHaveHome(){
    List<Home> homes = HomeHive.instance.getAllHomes();
    if(homes.isEmpty){
      return false;
    } else{
      return true;
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
    checkIfHaveRoutines();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: const BotNavBarWidget(
        index: 2,
      ),
      body: Padding(
        padding:
            EdgeInsets.only(right: 110.w, left: 110.w, bottom: 100.h, top: 400.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Routine',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 130.sp,
                  ),
                ),
                const Spacer(),
                if(checkIfHaveHome())
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                         SelectDevicePage(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    size: 130.sp,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100.h,
            ),
            Expanded(
              child: (haveFavouriteDevice)
                  ? HaveRoutinesWidget(
                      refreshPage: refreshPage,
                    )
                  : const NotRoutinesWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
