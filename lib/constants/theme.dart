import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 10.0;
double authMargin = 30.0;
Color primaryColor = const Color(0xFF3EB0F3);
Color infoColor = const Color(0xFF18C5FA);
Color disabledColor = const Color(0xFF969696);

Color warningColor = const Color(0xFFFCB42A);
Color dangerColor = const Color(0xFFFC502A);
Color titleColor = const Color(0xFF444444);
Color subtitleColor = const Color(0xFFA7A7A7);
Color bodyColor = const Color(0xFF9D9D9D);

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
  end: Alignment.topCenter,
  colors: [
    Color(0xFF313131).withOpacity(1),
    Colors.black.withOpacity(0),
    Colors.black.withOpacity(0),
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
  "Paid": const Color.fromRGBO(122, 233, 139, 1),
  "Waiting": const Color.fromRGBO(255, 168, 0, 1),
};

// Fonts
TextStyle digium = GoogleFonts.nunito(
    fontSize: 48,
    fontWeight: FontWeight.w900,
    letterSpacing: -0.045,
    color: Colors.white);

TextStyle title1 = GoogleFonts.playfairDisplay(
    fontSize: 48, fontWeight: bold, color: Colors.white);

TextStyle title2 = GoogleFonts.playfairDisplay(
    fontSize: 36, fontWeight: bold, color: titleColor);

TextStyle title3 = GoogleFonts.playfairDisplay(
    fontSize: 24, fontWeight: bold, color: titleColor);

TextStyle cardTitle1 =
    GoogleFonts.openSans(fontSize: 13, fontWeight: bold, color: Colors.white);

TextStyle subTitle1 = GoogleFonts.openSans(
    fontSize: 18, fontWeight: regular, color: subtitleColor);

TextStyle subTitle2 =
    GoogleFonts.openSans(fontSize: 14, fontWeight: regular, color: bodyColor);

TextStyle header1 = GoogleFonts.openSans(
    fontSize: 13, fontWeight: semiBold, color: subtitleColor);

TextStyle button2 = GoogleFonts.openSans(
    fontSize: 14, fontWeight: regular, color: primaryColor);

TextStyle headerSubTitle1 =
    GoogleFonts.openSans(fontSize: 18, fontWeight: light, color: Colors.white);

TextStyle button1 =
    GoogleFonts.openSans(fontSize: 18, fontWeight: bold, color: Colors.white);

TextStyle caption1 = GoogleFonts.openSans(
    fontSize: 14, fontWeight: regular, color: subtitleColor);

TextStyle body1 =
    GoogleFonts.openSans(fontSize: 12, fontWeight: light, color: Colors.black);
