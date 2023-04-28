
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
      Color.fromRGBO(26, 131, 255, 96),
      Color.fromRGBO(98, 122, 255, 90),
      Color.fromRGBO(138, 80, 255, 85),
      Color.fromRGBO(250, 28, 255, 80),
    ],
    begin: Alignment.topRight,
    stops: [0.1, 0.2,0.3, 0.4],
    end: Alignment(1, 1),

);