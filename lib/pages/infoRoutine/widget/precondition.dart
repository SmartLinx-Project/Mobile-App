import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/infoRoutine/widget/routineMode.dart';
import '../../../services/hive.dart';

class PreconditionRoutineWidget extends StatefulWidget {
  final Routine routine;
  const PreconditionRoutineWidget({super.key, required this.routine});

  @override
  State<PreconditionRoutineWidget> createState() =>
      _PreconditionRoutineWidgetState();
}

class _PreconditionRoutineWidgetState extends State<PreconditionRoutineWidget> {
  bool isScheduled() {
    if (widget.routine.time != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 50.w,
            ),
            Text(
              'Precondizione',
              style: TextStyle(
                color: Theme.of(context).textTheme.displayLarge?.color,
                fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 90.sp,
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 28,
        ),
        RoutineMode(
          routine: widget.routine,
        )
      ],
    );
  }
}
