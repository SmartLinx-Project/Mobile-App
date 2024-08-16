import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:smartlinx/pages/handleHomes/widget/homes_row_widget.dart";
import "package:smartlinx/pages/handleHomes/widget/no_home_found.dart";
import "package:smartlinx/pages/handleRooms/widget/finished_button.dart";
import "package:smartlinx/services/hiveMethod/home_hive.dart";

import "../../../services/hive.dart";


class CaseGrid extends StatefulWidget {
  const CaseGrid({super.key});

  @override
  State<CaseGrid> createState() => _CaseGridState();
}

class _CaseGridState extends State<CaseGrid> {
  final List<Widget> _membersWidget = [];

  @override
  void initState() {
    super.initState();
    _addMembers();
  }

  void _addMembers() {
    List<Home> homes = HomeHive.instance.getAllHomes();

    for (var home in homes) {
      _membersWidget.add(
        Column(
          children: [
            HomesRowWidget(home: home),
            SizedBox(height: 50.h),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _membersWidget.isNotEmpty ? _buildCaseGrid() : const NoHomeFound(),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.1,
          left: 0,
          right: 0,
          child: const Center(),
        ),
      ],
    );
  }

  Widget _buildCaseGrid() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: BorderRadius.circular(80.r),
          ),
          height: 1400.h,
          width: 3000.h,
          child: Padding(
            padding: EdgeInsets.all(100.h),
            child: ListView(
              children: _membersWidget,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        const FinishedButton(),
      ],
    );
  }
}
