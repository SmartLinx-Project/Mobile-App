import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.7); // Inizia leggermente sopra il punto medio a sinistra

    var firstControlPoint = Offset(size.width / 4, size.height * 0.8);
    var firstEndPoint = Offset(size.width / 2.25, size.height * 0.75);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
    Offset(size.width - (size.width / 3), size.height * 0.7); // Controllo per far salire l'onda
    var secondEndPoint = Offset(size.width, size.height * 0.7);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint = Offset(size.width - (size.width / 3) + 50, size.height * 0.75); // Controllo per far scendere l'onda
    var thirdEndPoint = Offset(size.width, size.height * 0.7);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    path.lineTo(size.width, size.height * 0.7); // Collegamento al punto medio a destra
    path.lineTo(size.width, 0); // Collegamento all'angolo in alto a destra
    path.lineTo(0, 0); // Collegamento all'angolo in alto a sinistra
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
