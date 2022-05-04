import 'package:digium/constants/theme.dart';
import 'package:digium/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class TopSearchBar extends StatefulWidget {
  const TopSearchBar({
    Key? key,
    required this.minTopBarHeight,
    required this.search,
  }) : super(key: key);

  final double minTopBarHeight;
  final Widget search;

  @override
  State<TopSearchBar> createState() => _TopSearchBarState();
}

class _TopSearchBarState extends State<TopSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: widget.minTopBarHeight,
        width: double.infinity,
        child: SafeArea(
          child: Container(
            height: 80,
            color: Colors.white,
            margin: EdgeInsets.all(defaultMargin),
            child: widget.search,
          ),
        ),
        decoration: BoxDecoration(
          gradient: mainGradient,
        ),
      ),
    );
  }
}
