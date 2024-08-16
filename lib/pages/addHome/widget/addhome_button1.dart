import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinx/pages/addHome/addhome_page.dart';

class AddHomebutton1 extends StatefulWidget {
  const AddHomebutton1({super.key});

  @override
  State<AddHomebutton1> createState() => _AddHomebutton1State();
}

class _AddHomebutton1State extends State<AddHomebutton1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
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
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddHomePage(),
            ),
          );
        },
        child: Text(
          'Adesso',
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
