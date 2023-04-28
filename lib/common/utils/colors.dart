
import 'package:flutter/material.dart';
const Map<int, Color> primarySwatch = {
  50: Color.fromRGBO(255, 207, 68, .1),
  100: Color.fromRGBO(255, 207, 68, .2),
  200: Color.fromRGBO(255, 207, 68, .3),
  300: Color.fromRGBO(255, 207, 68, .4),
  400: Color.fromRGBO(255, 207, 68, .5),
  500: Color.fromRGBO(255, 207, 68, .6),
  600: Color.fromRGBO(255, 207, 68, .7),
  700: Color.fromRGBO(255, 207, 68, .8),
  800: Color.fromRGBO(255, 207, 68, .9),
  900: Color.fromRGBO(255, 207, 68, 1),
};
const MaterialColor primaryColor = MaterialColor(0xFFFFCF44, primarySwatch);
const int primaryColorDark = 0xFFFD9725;
const Gradient ideArtColor1 = LinearGradient(
    colors: [
      Color.fromRGBO(7, 96, 251, 0.85),
      Color.fromRGBO(50, 81, 253, 0.80),
      Color.fromRGBO(115, 45, 255, 0.75),
      Color.fromRGBO(244, 11, 248, 0.70),
    ],
    begin: Alignment.topRight,
    stops: [.4, .5, .7, .8],
    end: Alignment(1, 1),

);