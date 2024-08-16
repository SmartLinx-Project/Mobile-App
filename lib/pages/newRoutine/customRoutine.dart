import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartlinx/pages/newRoutine/selDevicePage.dart';
import 'package:smartlinx/pages/newRoutine/widget/iconWid.dart';
import 'package:smartlinx/pages/routineDevice/routine_page.dart';
import 'package:smartlinx/services/hive.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';
import 'package:smartlinx/services/hiveMethod/routine_hive.dart';
import 'package:smartlinx/services/http.dart';
import 'package:smartlinx/services/init_app.dart';

class CustomRoutinePage extends StatefulWidget {
  final List<RoutineObject> routines;
  final DateTime? time;
  final List<String>? days;
  final Routine? previousRoutine;
  const CustomRoutinePage(
      {super.key,
      required this.routines,
      this.time,
      this.days,
      this.previousRoutine});

  @override
  State<CustomRoutinePage> createState() => _CustomRoutinePageState();
}

class _CustomRoutinePageState extends State<CustomRoutinePage> {
  final int iconLength = 20;
  int selectedIcon = 1;
  TextEditingController nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  List<Widget> icons = [];
  ScrollController scrollController = ScrollController();
  bool isLoading = false;

  void fillIcons() {
    icons = [];
    for (int i = 1; i < iconLength + 1; i++) {
      icons.add(
        RoutineIconWidget(
          setSelectedIcon: setSelectedIcon,
          getSelectedIcon: getSelectedIcon,
          iconIndex: i,
        ),
      );
    }
  }

  int getSelectedIcon() {
    return selectedIcon;
  }

  void setSelectedIcon(int newValue) {
    setState(() {
      selectedIcon = newValue;
    });
  }

  String createJson() {
    List<Map<String, dynamic>> jsonList =
        widget.routines.map((routine) => routine.toJson()).toList();
    String jsonString = jsonEncode({'actions': jsonList});
    return jsonString;
  }

  void addRoutine() async {
    String bodyJson = createJson();
    int routineID = RoutineHive.instance.getNewID();
    Routine newRoutine = Routine(
        routineID: routineID,
        name: nameController.text,
        icon: selectedIcon.toString(),
        body: bodyJson,
        homeID: HomeHive.instance.getCurrentHome()!,
        enabled: true,
        periodicity: widget.days,
        time: widget.time);
    setState(() {
      isLoading = true;
    });
    if (await HttpService().addRoutine(routine: newRoutine)) {
      await InitApp().startInit();
      redirectToInitialPage();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void redirectToInitialPage() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => const RoutinePage(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  void checkPreviousRoutine() {
    if (widget.previousRoutine == null) {
      return;
    }
    nameController.text = widget.previousRoutine!.name;
    selectedIcon = int.parse(widget.previousRoutine!.icon);
  }

  void editRoutine() async {
    String bodyJson = createJson();
    Routine updatedRoutine = Routine(
        routineID: widget.previousRoutine!.routineID,
        name: nameController.text,
        icon: selectedIcon.toString(),
        body: bodyJson,
        homeID: HomeHive.instance.getCurrentHome()!,
        enabled: true,
        periodicity: widget.days,
        time: widget.time);
    setState(() {
      isLoading = true;
    });
    if (await HttpService().setRoutine(routine: updatedRoutine)) {
      await InitApp().startInit();
      redirectToInitialPage();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    checkPreviousRoutine();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fillIcons();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).textTheme.displayLarge?.color,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Personalizza Routine',
          style: TextStyle(
            color: Theme.of(context).textTheme.displayLarge?.color,
            fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
            fontWeight: FontWeight.normal,
            fontSize: 70.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150.h,
            ),
            Row(
              children: [
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  height: 350.h,
                  width: 350.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/routine_icon/$selectedIcon.svg',
                    height: 220.sp,
                  ),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(
              height: 150.h,
            ),
            Container(
              height: 400.h,
              width: 1200.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60.r),
                color: Theme.of(context).colorScheme.onSurface,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 70.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nome Routine',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.displayMedium?.color,
                        fontFamily:
                            Theme.of(context).textTheme.displayMedium?.fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 50.sp,
                      ),
                    ),
                    const Spacer(),
                    TextField(
                      onChanged: (a) {
                        setState(() {});
                      },
                      onTapOutside: (a) {
                        nameFocusNode.unfocus();
                      },
                      focusNode: nameFocusNode,
                      controller: nameController,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.displayLarge?.color,
                        fontFamily:
                            Theme.of(context).textTheme.displayLarge?.fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 70.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            Container(
              height: 1150.h,
              width: 1200.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60.r),
                color: Theme.of(context).colorScheme.onSurface,
              ),
              child: Padding(
                padding: EdgeInsets.all(40.w),
                child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  radius: const Radius.circular(300),
                  thickness: 4,
                  child: Padding(
                    padding: EdgeInsets.all(40.w),
                    child: GridView.builder(
                      controller:
                          scrollController, // Associate the controller here
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150.h,
                        crossAxisSpacing: 150.h,
                        mainAxisSpacing: 100.h,
                        mainAxisExtent: 150.h,
                      ),
                      itemCount: iconLength,
                      itemBuilder: (context, index) {
                        return icons[index];
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 120.h,
            ),
            Container(
              width: 850.w,
              height: 180.h,
              decoration: BoxDecoration(
                color: (nameController.text.isNotEmpty)
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withOpacity(0.6),
                borderRadius: BorderRadius.circular(150.r),
              ),
              child: TextButton(
                onPressed: () async {
                  if ((nameController.text.isNotEmpty)) {
                    if (widget.previousRoutine == null) {
                      addRoutine();
                    } else {
                      editRoutine();
                    }
                  }
                },
                child: (!isLoading)
                    ? Text(
                        (widget.previousRoutine == null)
                            ? 'Aggiungi Routine'
                            : 'Modifica Routine',
                        style: TextStyle(
                          fontFamily: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 68.sp,
                          color: ((nameController.text.isNotEmpty))
                              ? Colors.white
                              : Colors.white.withOpacity(0.9),
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Transform.scale(
                        scale: 0.8,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
