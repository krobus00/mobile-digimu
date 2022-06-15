import 'package:flutter/material.dart';
import 'package:digium/models/museum_model.dart';
import 'package:digium/constants/endpoint.dart';
import 'package:digium/utils/utils.dart';

class DetailMuseumHeader extends StatelessWidget {
  final MuseumModel museum;

  // ignore: use_key_in_widget_constructors
  const DetailMuseumHeader({
    required this.museum,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            getAssetURL(assetMuseumURL, museum.background),
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SafeArea(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                      )),
                  Spacer(),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.share,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            Text(
              museum.name,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double get maxExtent => 230;

  double get minExtent => 100;

  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
