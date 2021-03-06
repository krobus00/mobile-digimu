import 'dart:math';

import 'package:digium/constants/theme.dart';
import 'package:digium/widgets/top_search_header.dart';
import 'package:flutter/material.dart';

class MuseumHeader extends SliverPersistentHeaderDelegate {
  final double minTopBarHeight = 100;
  final double maxTopBarHeight = 200;
  final String title;
  final IconData icon;
  final Widget search;

  MuseumHeader({
    required this.title,
    required this.icon,
    required this.search,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    var shrinkFactor = min(1, shrinkOffset / (maxExtent - minExtent));

    var topSearchBar = TopSearchBar(
      minTopBarHeight: minTopBarHeight,
      search: search,
    );

    var topBar = Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: max(
          maxTopBarHeight * (1 - shrinkFactor * 1.45),
          minTopBarHeight,
        ),
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Museum List",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Here are some museums to check",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(defaultMargin),
                  width: double.infinity,
                  decoration: const BoxDecoration(),
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
          gradient: mainGradient,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
      ),
    );
    return SizedBox(
      height: max(maxExtent - shrinkOffset, minExtent),
      child: Stack(
        fit: StackFit.loose,
        children: [
          if (shrinkFactor <= 0.5) topBar,
          if (shrinkFactor <= 0.4)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: search,
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1),
                      )
                    ],
                  ),
                ),
              ),
            ),
          if (shrinkFactor > 0.5) topSearchBar,
        ],
      ),
    );
  }

  @override
  double get maxExtent => 230;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
