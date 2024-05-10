import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/addRoom/widget/add_room_button.dart';
import 'package:smartlinx/pages/addRoom/widget/new_room_field.dart';
import '../../services/hive.dart';
import '../../services/hiveMethod/home_hive.dart';

class AddRoom extends StatefulWidget {
  final Home home;
  const AddRoom({super.key, required this.home});

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Home> homes = HomeHive.instance.getAllHomes();
    List<int> caseList = [];
    for (int i = 0; i < homes.length; i++) {
      caseList.add(homes[i].homeID);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100.w),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100.h),
                Text(
                  "Aggiungi Stanza",
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.displayLarge?.fontFamily,
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 130.sp,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 200.h),
                Text(
                  "Nome",
                  style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.displayMedium?.fontFamily,
                    color: Theme.of(context).textTheme.displayMedium?.color,
                    fontWeight: FontWeight.w500,
                    fontSize: 65.sp,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fade(duration: 700.ms, delay: 0.ms),
                SizedBox(height: 80.h),
                NewRoomField(
                  controller: nameController,
                  hintText: 'Nome stanza',
                ).animate().fade(duration: 700.ms, delay: 0.ms),
                SizedBox(height: 1400.h),
                if (nameController.text.isNotEmpty)
                  Center(
                    child: AddRoomButton(
                            home: widget.home, nameController: nameController)
                        .animate()
                        .fade(duration: 700.ms, delay: 0.ms),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
