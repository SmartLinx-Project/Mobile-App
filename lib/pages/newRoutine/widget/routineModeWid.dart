import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class RoutineModeWidget extends StatefulWidget {
  final int type;
  final Function getCurrentMode;
  final Function setCurrentMode;
  const RoutineModeWidget(
      {super.key,
      required this.type,
      required this.getCurrentMode,
      required this.setCurrentMode});

  @override
  State<RoutineModeWidget> createState() => _RoutineModeWidgetState();
}

class _RoutineModeWidgetState extends State<RoutineModeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController iconController;

  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    iconController = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 850),
    );
  }

  void checkSelectedMode() async{
    if (widget.getCurrentMode() == widget.type) {
      isSelected = true;
    } else {
      isSelected = false;
    }
    if (isSelected) {
      iconController.reset();
      await iconController.forward();
      iconController.reset();
      iconController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    checkSelectedMode();
    return GestureDetector(
      onTap: () {
        widget.setCurrentMode(widget.type);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60.w),
        child: Container(
          height: MediaQuery.of(context).size.height / 6,
          width: double.infinity,
          decoration: BoxDecoration(
              color: (isSelected)
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              borderRadius: BorderRadius.circular(70.r),
              border: Border.all(
                  color: (!isSelected)
                      ? Colors.transparent
                      : Theme.of(context).iconTheme.color!.withOpacity(0.6),
                  width: 3)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (widget.type == 0) ? 'Avvio Manuale' : 'Avvio Schedulato',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.displayLarge?.color,
                        fontFamily:
                            Theme.of(context).textTheme.displayLarge?.fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 75.sp,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 35,
                    ),
                    Text(
                      (widget.type == 0)
                          ? 'Decidi tu quando eseguire la\nroutine toccando il tasto'
                          : 'Lascia che sia l\'app ad eseguire\nper te la routine automaticamente',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.displayLarge?.color,
                        fontFamily:
                            Theme.of(context).textTheme.displayLarge?.fontFamily,
                        fontWeight: FontWeight.normal,
                        fontSize: 55.sp,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Center(
                  child: Lottie.asset(
                      (widget.type == 0)
                          ? 'assets/lottie/play_button.json'
                          : 'assets/lottie/hourglass.json',
                      height: 370.sp,
                      repeat: false,
                      controller: iconController),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
