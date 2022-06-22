import 'package:digium/constants/endpoint.dart';
import 'package:digium/models/gallery_model.dart';
import 'package:digium/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleriesTab extends StatelessWidget {
  final List<GalleryModel> galleries;
  const GalleriesTab({Key? key, required this.galleries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        itemCount: galleries.length,
        itemBuilder: (_, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.network(
                getAssetURL(assetMuseumURL, galleries[index].photo),
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      ),
    );
  }
}
