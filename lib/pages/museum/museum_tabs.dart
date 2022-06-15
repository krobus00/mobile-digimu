import 'package:digium/constants/theme.dart';
import 'package:digium/pages/museum/about_tab.dart';
import 'package:digium/pages/museum/galleries_tab.dart';
import 'package:flutter/material.dart';
import 'package:digium/models/museum_model.dart';

class MuseumTabs extends StatelessWidget {
  final MuseumModel museum;
  // ignore: use_key_in_widget_constructors
  const MuseumTabs({required this.museum});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, // length of tabs
        initialIndex: 0,
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
                          top: BorderSide(color: Colors.grey, width: 0.5))),
                  child: TabBarView(children: <Widget>[
                    AboutTab(museum: museum),
                    GalleriesTab(
                        // galleries: museum.galleries
                        ),
                  ]))
            ]));
  }
}
