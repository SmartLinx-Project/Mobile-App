import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/homePage/home_page.dart';

class AddHomebutton2 extends StatefulWidget {
  const AddHomebutton2({super.key});

  @override
  State<AddHomebutton2> createState() => _AddHomebutton2State();
}

class _AddHomebutton2State extends State<AddHomebutton2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Colore e opacità dell'ombra
            offset: const Offset(0, 3), // Direzione dell'ombra (dx, dy)
            blurRadius: 6, // Raggio di sfocatura
            spreadRadius: 0, // Espansione dell'ombra
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => false,
          );
        },
        child: Text(
          'Più tardi',
          style: TextStyle(
            fontFamily: Theme.of(context).textTheme.displayLarge?.fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 80.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
