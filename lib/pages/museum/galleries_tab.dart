import 'package:digium/models/gallery_model.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleriesTab extends StatelessWidget {
  // final List<GalleryModel>? galleries;
  // ignore: use_key_in_widget_constructors
  GalleriesTab(
      // {required this.galleries}
      );

  List img = [
    'https://images.unsplash.com/photo-1655282880891-9151896afab5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    'https://images.unsplash.com/photo-1638913970895-d3df59be1466?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1331&q=80',
    'https://images.unsplash.com/photo-1655070249064-2556803629b6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=388&q=80',
    'https://images.unsplash.com/photo-1655284847835-1684a56f80d2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1075&q=80',
    'https://images.unsplash.com/photo-1655240651407-c1e4618639e7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    'https://images.unsplash.com/photo-1655070115142-c73783108452?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80'
  ];

  // ignore: empty_constructor_bodies
  @override
  // ignore: dead_code
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          itemCount: img.length,
          itemBuilder: (_, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: Image.network(
                    img[index],
                    fit: BoxFit.fill,
                  )),
            );
          },
          // staggeredTileBuilder: (index) {
          //   return StaggeredTile.count(1, index.isEven ? 1.2 : 2);
          // }
        ),
      ),
    );
  }
}
