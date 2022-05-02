import 'package:digium/models/museum_model.dart';
import 'package:flutter/material.dart';

class MuseumDetailPage extends StatelessWidget {
  const MuseumDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as MuseumDetailArguments;
    final museum = arguments.museum;

    return Scaffold(
      body: Center(child: Text(museum.name)),
    );
  }
}

class MuseumDetailArguments {
  final MuseumModel museum;

  MuseumDetailArguments({required this.museum});
}
