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
    titleColor: const Color.fromRGBO(68, 68, 68, 1),
    desc: "Amazing museums to visit all over Indonesia",
    descColor: const Color.fromRGBO(166, 166, 166, 1),
    bgImg: "assets/onboard/background/bgOnboard1.png",
    btnColor: const Color.fromRGBO(62, 176, 243, 1),
    btnTextColor: Colors.white,
  ),
  OnboardModel(
    img: "assets/onboard/onboard2.png",
    title: "Perluas Wawasan",
    titleColor: Colors.white,
    desc: "Increase your knowledge about museums",
    descColor: Colors.white,
    bgImg: "assets/onboard/background/bgOnboard2.png",
    btnColor: Colors.white,
    btnTextColor: const Color.fromRGBO(62, 176, 243, 1),
  ),
];
