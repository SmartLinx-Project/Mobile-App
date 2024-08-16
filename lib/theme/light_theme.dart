import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color(0XFFFFFFFF),
    primary: Color(0XFF998EFE),
    secondary: Color(0XFFDAD5FF),
    primaryContainer: Color(0xFFF3F3F3), //container per le texfield
    secondaryContainer: Color(0xFF000000), //colore generico bianco/nero
    tertiary: Color(
        0xFFE7F4FE), //colore dello sfondo del container del meteo nella homepage
    onSurface: Color(0xFFEFEFEF), //colore secondario della homepage dell'onda
    onSurfaceVariant: Color(0xFFFFFFFF), //colore altro della homepage
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        color: Color(0xFF000000),
        fontFamily: 'SFProDisplay'), //Da definire fontSize e FontWeight
    displayMedium: TextStyle(
        color: Color(0xFF464646),
        fontFamily: 'SFProDisplay'), //Da definire fontSize e FontWeight
    displaySmall: TextStyle(
        color: Color(0xFF464646),
        fontFamily: 'SFProDisplay'), //Da definire fontSize e FontWeight
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color(0XFFFFFFFF),
      iconTheme: IconThemeData(color: Color(0xFF000000)),
      titleTextStyle: TextStyle(
          color: Color(0xFF000000)) //Da definire fontSize e FontWeight
      //da definire il pulsante cliccato
      ),
  bottomSheetTheme: const BottomSheetThemeData(
    //Finestra Popup che sale dal basso
    backgroundColor: Color(0xFFFFFFFF),
    //definire modalità
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
    unselectedItemColor: Color(0xFF484C52),
    selectedItemColor: Color(0XFF998EFE),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xffd3d3d3),
  ),
  cardColor: const Color(0xFFFFFFFF),
);
