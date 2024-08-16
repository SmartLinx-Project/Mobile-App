import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartlinx/pages/editRoom/widget/confirm_buttons.dart';
import 'package:smartlinx/pages/editRoom/widget/appbar.dart';
import 'package:smartlinx/pages/editRoom/widget/field.dart';
import 'package:smartlinx/pages/editRoom/widget/select_home.dart';
import 'package:smartlinx/services/hiveMethod/home_hive.dart';

import '../../services/hive.dart';

class EditRoomPage extends StatefulWidget {
  final Room room;
  const EditRoomPage({super.key, required this.room});

  @override
  State<EditRoomPage> createState() => _EditRoomPageState();
}

class _EditRoomPageState extends State<EditRoomPage> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.room.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarEditRoom(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Stack(
            children: [
              Positioned(
                top: 1200.h,
                right: 0.h,
                child: SvgPicture.asset('assets/svg/house-interior.svg',
                    height: 950.h),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 250.h,
                    ),
                    HandleRoomField(
                      text: 'Nome',
                      controller: nameController,
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    SelectHomeMenu(
                      home: HomeHive.instance.getHomeFromID(widget.room.homeID),
                      room: widget.room,
                    ),
                    SizedBox(
                      height: 1700.h,
                    ),
                    HandleRoomConfirmButtons(
                      room: widget.room,
                      nameController: nameController,
                    ),
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
