import 'package:digium/pages/museum/about_tab.dart';
import 'package:digium/pages/museum/galleries_tab.dart';
import 'package:flutter/material.dart';
import 'package:digium/models/museum_model.dart';

class MuseumTabs extends StatelessWidget {
  final MuseumModel museum;
  const MuseumTabs({Key? key, required this.museum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(text: 'About'),
              Tab(text: 'Galleries'),
            ],
          ),
          Container(
            height: 400, //height of TabBarView
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: TabBarView(
              children: <Widget>[
                AboutTab(museum: museum),
                GalleriesTab(galleries: museum.galleries ?? []),

                // GalleriesTab(
                //     // galleries: museum.galleries
                //     ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
