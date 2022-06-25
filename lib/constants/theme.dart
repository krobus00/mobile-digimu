import 'package:flutter/material.dart';

double defaultMargin = 10.0;
double authMargin = 30.0;
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

LinearGradient cardGradient = LinearGradient(
  begin: Alignment.bottomCenter,
  colors: [
    Colors.black.withOpacity(.4),
    Colors.black.withOpacity(.1),
  ],
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

Map<String, Color> transactionStatusColor = {
  "Paid": const Color.fromRGBO(122, 233, 139, 1),
  "Waiting Payment": const Color.fromRGBO(255, 168, 0, 1),
  "Cancelled": const Color.fromRGBO(255, 61, 0, 1),
  "Waiting Verification": const Color.fromRGBO(255, 168, 0, 1),
};

Map<String, String> transactionStatus = {
  "Paid": "Paid",
  "Waiting Payment": "Payment",
  "Cancelled": "Cancelled",
  "Waiting Verification": "Verification",
};

Map<String, Color> transactionItemStatusColor = {
  "Verified": const Color.fromRGBO(122, 233, 139, 1),
  "Waiting": const Color.fromRGBO(255, 168, 0, 1),
};
