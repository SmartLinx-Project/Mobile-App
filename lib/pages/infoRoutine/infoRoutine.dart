import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartlinx/pages/infoRoutine/widget/actions.dart';
import 'package:smartlinx/pages/infoRoutine/widget/precondition.dart';
import 'package:smartlinx/pages/newRoutine/selDevicePage.dart';
import 'package:smartlinx/pages/routineDevice/routine_page.dart';
import 'package:smartlinx/services/hiveMethod/routine_hive.dart';
import '../../services/hive.dart';
import '../../services/http.dart';

class RoutineInfoPage extends StatefulWidget {
  final Routine routine;
  const RoutineInfoPage({super.key, required this.routine});

  @override
  State<RoutineInfoPage> createState() => _RoutineInfoPageState();
}

class _RoutineInfoPageState extends State<RoutineInfoPage> {
  void editRoutine() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => SelectDevicePage(
          previousRoutine: widget.routine,
        ),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    const RoutinePage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).textTheme.displayLarge?.color,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Informazioni Routine',
          style: TextStyle(
            color: Theme.of(context).textTheme.displayLarge?.color,
            fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
            fontWeight: FontWeight.normal,
            fontSize: 70.sp,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.w),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 350.h,
                        width: 350.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/routine_icon/${widget.routine.icon}.svg',
                          height: 220.sp,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 16,
                      ),
                      Container(
                        height: 220.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSurface,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          widget.routine.name,
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.fontFamily,
                            fontWeight: FontWeight.w500,
                            fontSize: 80.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 16,
                      ),
                      PreconditionRoutineWidget(
                        routine: widget.routine,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 16,
                      ),
                      RoutineActionWidget(
                        routine: widget.routine,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 14,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () {
                    editRoutine();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        size: 65.sp,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Modifica',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.displayMedium?.color,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.fontFamily,
                          fontWeight: FontWeight.normal,
                          fontSize: 40.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    if (await HttpService()
                        .delRoutine(routineID: widget.routine.routineID)) {
                      await RoutineHive.instance
                          .removeRoutine(widget.routine.routineID);
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const RoutinePage(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                        (route) => false,
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_outline,
                        size: 65.sp,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Elimina',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.displayMedium?.color,
                          fontFamily: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.fontFamily,
                          fontWeight: FontWeight.normal,
                          fontSize: 40.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
