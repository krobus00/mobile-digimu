import 'package:flutter/material.dart';

double defaultMargin = 30.0;
Color primaryColor = const Color(0xFF3EB0F3);
Color infoColor = const Color(0xFF18C5FA);
Color disabledColor = const Color(0xFF969696);

Color warningColor = const Color(0xFFFCB42A);
Color dangerColor = const Color(0xFFFC502A);
Color titleColor = const Color(0xFF444444);
Color subtitleColor = const Color(0xFFA7A7A7);

LinearGradient mainGradient = const LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    Color(0xFF18C5FA),
    Color(0xFF57A3EF),
  ],
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
