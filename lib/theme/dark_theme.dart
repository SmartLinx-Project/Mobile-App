import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color(0XFF010101),
    primary: Color(0XFF998EFE),
    secondary: Color(0XFFDAD5FF),
    primaryContainer: Color(0xFF1A1A1A), //container per le texfield
    secondaryContainer: Color(0xFFFFFFFF), //colore generico bianco/nero
    tertiary: Color(
        0xFF20202E), //colore dello sfondo del container del meteo nella homepage
    onSurface: Color(0xFF20202E), //colore secondario della homepage dell'onda
    onSurfaceVariant: Color(0xFF010101), //colore altro della homepage
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        color: Color(0xFFFFFFFF),
        fontFamily: 'SFProDisplay'), //Da definire fontSize e FontWeight
    displayMedium: TextStyle(
        color: Color(0xFFE7E7E7),
        fontFamily: 'SFProDisplay'), //Da definire fontSize e FontWeight
    displaySmall: TextStyle(
        color: Color(0xFFE7E7E7),
        fontFamily: 'SFProDisplay'), //Da definire fontSize e FontWeight
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color(0XFF010101),
      iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
      titleTextStyle: TextStyle(
          color: Color(0xFFFFFFFF)) //Da definire fontSize e FontWeight
      ),
  bottomSheetTheme: const BottomSheetThemeData(
    //Finestra Popup che sale dal basso
    backgroundColor: Color(0xFF20202E),
    //definire modalità
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
    unselectedItemColor: Color(0xFFD0D0D0),
    selectedItemColor: Color(0XFF998EFE),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xFF20202E),
  ),
  cardColor: const Color(0xFF20202e),
);
