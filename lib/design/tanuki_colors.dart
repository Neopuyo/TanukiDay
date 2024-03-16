// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';


class TanukiColor {
  static const BG_COLOR                                 = Color(0xFF30303F);
  static const ACCENT                                   = Color(0xFF1DF0AA);
  static const PRIMARY                                  = Color(0xFF1994AA);
  static const SECONDARY                                = Color(0xFFF58235);
  static const PRIMARY_WRITE_UP                         = Color(0xFF0D637E);
    static const PRIMARY_WRITE_UP_L1                    = Color(0xFF0E7999);


  static const TEXT_COLOR                               = Color(0xFF9e9e9e);
  static const BODY_COLOR                               = Color(0xFF474764);
  static const BLACK                                    = Color(0xFF000000);
  static const GREY                                     = Color(0xFF3a3f49);

  // Feelings
  static const VERY_HAPPY                               = Color(0xFF00E699);
  static const HAPPY                                    = Color(0xFFDDEC07);
  static const UNHAPPY                                  = Color(0xFFF7772E);
  static const VERY_UNHAPPY                             = Color(0xFFE63838);



  static const MaterialColor primarySwatch = MaterialColor(0xFF1994AA, <int, Color>{
     50: Color(0xFFB2E8E5),
    100: Color(0xFF80D7D3),
    200: Color(0xFF4DBBB9),
    300: Color(0xFF26A6A0),
    400: Color(0xFF1994AA),
    500: Color(0xFF00899B),
    600: Color(0xFF007C87),
    700: Color(0xFF006F74),
    800: Color(0xFF006260),
    900: Color(0xFF004D4A),
  });

  static const MaterialColor accentSwatch = MaterialColor(0xFF1DF0AA, <int, Color>{
     50: Color(0xFFB2F9E6),
    100: Color(0xFF88F2D8),
    200: Color(0xFF5DEBCA),
    300: Color(0xFF32E0BB),
    400: Color(0xFF1DF0AA),
    500: Color(0xFF00E699),
    600: Color(0xFF00CC88),
    700: Color(0xFF00B277),
    800: Color(0xFF009966),
    900: Color(0xFF008055),
  });
  
  static Color getColorFromStringFeeling({required String feeling}) {
    switch (feeling) {
      case 'sentiment_very_dissatisfied_outlined':
        return VERY_UNHAPPY;
      case 'sentiment_dissatisfied_outlined':
        return UNHAPPY;
      case 'sentiment_neutral_outlined':
        return TEXT_COLOR;
      case 'sentiment_satisfied_outlined':
        return HAPPY;
      case 'sentiment_very_satisfied_outlined':
        return VERY_HAPPY;
      default:
        return TEXT_COLOR;
    }
  }
}