import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoutineIconWidget extends StatefulWidget {
  final int iconIndex;
  final Function getSelectedIcon;
  final Function setSelectedIcon;
  const RoutineIconWidget(
      {super.key,
      required this.iconIndex,
      required this.getSelectedIcon,
      required this.setSelectedIcon});

  @override
  State<RoutineIconWidget> createState() => _RoutineIconWidgetState();
}

class _RoutineIconWidgetState extends State<RoutineIconWidget> {
  bool isSelected = false;

  void checkSelectedIcon() {
    int selectedIcon = widget.getSelectedIcon();
    if (selectedIcon == widget.iconIndex) {
      isSelected = true;
    } else {
      isSelected = false;
    }
  }

  void setSelectedIcon() {
    widget.setSelectedIcon(widget.iconIndex);
  }

  @override
  Widget build(BuildContext context) {
    checkSelectedIcon();
    return GestureDetector(
      onTap: () {
        setSelectedIcon();
      },
      child: Container(
        height: 170.h,
        width: 170.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(500),
          border: Border.all(
              color: (isSelected)
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              width: 2.5),
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/svg/routine_icon/${widget.iconIndex}.svg',
            height: 100.h,
          ),
        ),
      ),
    );
  }
}
