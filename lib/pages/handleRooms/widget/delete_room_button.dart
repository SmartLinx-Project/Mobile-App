import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/homePage/home_page.dart';

class EliminaStanzaButton extends StatefulWidget {
  const EliminaStanzaButton({super.key});

  @override
  State<EliminaStanzaButton> createState() => _EliminaStanzaButtonState();
}

class _EliminaStanzaButtonState extends State<EliminaStanzaButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.325,
      height: 200.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(100.r),

      ),
      child: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          child: Text(
            'Elimina',
            style: TextStyle(
              fontFamily:
              Theme.of(context).textTheme.displayLarge?.fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 65.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
