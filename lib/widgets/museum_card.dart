import 'package:digium/constants/endpoint.dart';
import 'package:digium/models/museum_model.dart';
import 'package:digium/theme.dart';
import 'package:digium/utils.dart';
import 'package:flutter/material.dart';

class MuseumCard extends StatelessWidget {
  final MuseumModel museum;

  const MuseumCard({Key? key, required this.museum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 215,
      height: 170,
      margin: EdgeInsets.only(
        right: defaultMargin,
      ),
      decoration: BoxDecoration(
        color: const Color(0xff7c94b6),
        borderRadius: BorderRadius.circular(15.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.dstATop,
          ),
          image: NetworkImage(
            getAssetURL(assetMuseumURL, museum.background),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  museum.yearBuilt.year.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    overflow: TextOverflow.fade,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  museum.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: semiBold,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
