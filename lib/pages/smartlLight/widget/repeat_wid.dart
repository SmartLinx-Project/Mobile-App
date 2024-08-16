import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'day_wid.dart';

class RepeatWidget extends StatefulWidget {
  List<String> periodicity;
  List<dayofWeek> week;
  RepeatWidget({super.key, required this.periodicity, required this.week});

  @override
  State<RepeatWidget> createState() => _RepeatWidgetState();
}

class _RepeatWidgetState extends State<RepeatWidget> {
  late List<Widget> dayWidgets;
  Map<String, List<String>> engToIta = {
    'monday': ['Lun'],
    'tuesday': ['Mar'],
    'wednesday': ['Mer'],
    'thursday': ['Gio'],
    'friday': ['Ven'],
    'saturday': ['Sab'],
    'sunday': ['Dom'],
  };

  List<Widget> buildDayWidgets() {
    dayWidgets = [];
    widget.week.clear();
    List<String> days = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday'
    ];
    for (int i = 0; i < 7; i++) {
      widget.week.add(dayofWeek(days[i], false));
    }
    for (int i = 0; i < widget.periodicity.length; i++) {
      String currentDay = widget.periodicity[i];
      for (int a = 0; a < widget.week.length; a++) {
        if (currentDay == widget.week[a].name) {
          widget.week[a].isSelected = true;
        }
      }
    }

    for (int i = 0; i < widget.week.length; i++) {
      dayWidgets.add(DayWidget(
          date: engToIta[widget.week[i].name]![0], day: widget.week[i]));
      dayWidgets.add(SizedBox(
        width: 40.w,
      ));
    }

    return dayWidgets;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    buildDayWidgets();
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: dayWidgets,
          ),
        ),
        SizedBox(
          height: 100.h,
        ),
      ],
    );
  }
}

class dayofWeek {
  String name;
  bool isSelected;

  dayofWeek(this.name, this.isSelected);
}
