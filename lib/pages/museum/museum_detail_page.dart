import 'package:digium/models/museum_model.dart';
import 'package:digium/pages/museum/price_buy.dart';
import 'package:digium/pages/museum/museum_tabs.dart';
import 'package:flutter/material.dart';
import 'package:digium/widgets/header_detail_museum.dart';

class MuseumDetailPage extends StatelessWidget {
  const MuseumDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as MuseumDetailArguments;
    final museum = arguments.museum;

    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DetailMuseumHeader(
              museum: museum,
            ),
            MuseumTabs(
              museum: museum,
            ),
          ]),
    );
  }
}

class MuseumDetailArguments {
  final MuseumModel museum;

  MuseumDetailArguments({required this.museum});
}
