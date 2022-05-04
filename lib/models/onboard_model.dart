import 'package:digium/constants/theme.dart';
import 'package:flutter/material.dart';

class OnboardModel {
  String img;
  String title;
  Color titleColor;
  String desc;
  Color descColor;
  String bgImg;
  Color btnColor;
  Color btnTextColor;

  OnboardModel({
    required this.img,
    required this.title,
    required this.titleColor,
    required this.desc,
    required this.descColor,
    required this.bgImg,
    required this.btnColor,
    required this.btnTextColor,
  });
}

List<OnboardModel> screens = <OnboardModel>[
  OnboardModel(
    img: "assets/onboard/onboard1.png",
    title: "Mulai Petualanganmu",
    titleColor: titleColor,
    desc: "Amazing museums to visit all over Indonesia",
    descColor: subtitleColor,
    bgImg: "assets/onboard/background/bgOnboard1.png",
    btnColor: primaryColor,
    btnTextColor: Colors.white,
  ),
  OnboardModel(
    img: "assets/onboard/onboard2.png",
    title: "Perluas\nWawasan",
    titleColor: Colors.white,
    desc: "Increase your knowledge about museums",
    descColor: Colors.white,
    bgImg: "assets/onboard/background/bgOnboard2.png",
    btnColor: Colors.white,
    btnTextColor: primaryColor,
  ),
];
