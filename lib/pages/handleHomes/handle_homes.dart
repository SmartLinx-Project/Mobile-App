import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/handleHomes/widget/appbar_handleRooms.dart';
import 'package:smartlinx/pages/handleHomes/widget/CaseGrid.dart';
import 'package:smartlinx/pages/handleHomes/widget/no_home_found.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';



class HandleHomes extends StatefulWidget {
  const HandleHomes({super.key});

  @override
  State<HandleHomes> createState() => _HandleHomesState();
}

class _HandleHomesState extends State<HandleHomes> {

  bool haveHome = false;


  void checkHomes(){
    if(HomeHive.instance.getAllHomes().isNotEmpty){
      haveHome = true;
    }
  }

  @override
  void initState() {
    super.initState();
    checkHomes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHandleHomes(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(150.w, 150.h, 150.w, 150.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Case",
                style: TextStyle(
                  fontFamily:
                  Theme.of(context).textTheme.displayLarge?.fontFamily,
                  color: Theme.of(context).textTheme.displayLarge?.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 120.sp,
                ),
              ),
              Text(
                "Gestisci le tue case",
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              haveHome ? const CaseGrid() : const NoHomeFound(),
            ],
          ),
        ),
      ),
    );
  }
}
