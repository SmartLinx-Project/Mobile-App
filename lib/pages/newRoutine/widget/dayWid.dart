import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoutineDayWidget extends StatefulWidget {
  final String day;
  final String visualizedDay;
  final Function addDay;
  final Function removeDay;
  final Function checkSelected;
  const RoutineDayWidget({super.key, required this.day, required this.visualizedDay, required this.addDay, required this.removeDay, required this.checkSelected});

  @override
  State<RoutineDayWidget> createState() => _RoutineDayWidgetState();
}

class _RoutineDayWidgetState extends State<RoutineDayWidget> {
  String day = '';

  void handleSelect(){
    if(checkSelected()){
      widget.removeDay(day);
    } else{
      widget.addDay(day);
    }
  }

  bool checkSelected(){
    return widget.checkSelected(day);
  }

  @override
  void initState() {
    day = widget.day;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          handleSelect();
        });
        print('ciao');
      },
      child: Container(
        height: 115.h,
        width: 115.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(400.r),
          border: Border.all(
            color: checkSelected()
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).iconTheme.color!,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            widget.visualizedDay,
            style: TextStyle(
              color: checkSelected()
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).textTheme.displayLarge?.color,
              fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
              fontWeight: FontWeight.w500,
              fontSize: 63.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
