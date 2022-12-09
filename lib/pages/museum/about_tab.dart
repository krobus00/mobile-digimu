import 'package:digium/constants/theme.dart';
import 'package:digium/models/museum_model.dart';
import 'package:digium/widgets/custom_map.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AboutTab extends StatelessWidget {
  final MuseumModel museum;

  AboutTab({
    Key? key,
    required this.museum,
  }) : super(key: key);

  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33),
          child: Text(
            "About",
            textAlign: TextAlign.left,
            style: title3,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33),
          child: Text(
            museum.description,
            textAlign: TextAlign.justify,
            style: body1,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33),
          child: Text(
            "Information",
            textAlign: TextAlign.left,
            style: title3,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.pin_drop,
                color: primaryColor,
              ),
              const SizedBox(width: 20),
              Flexible(
                  child: Text(
                museum.address,
                style: body1,
              )),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33),
          child: Row(
            children: [
              Icon(
                Icons.phone_enabled_outlined,
                color: primaryColor,
              ),
              const SizedBox(width: 20),
              Flexible(
                  child: Text(
                museum.phone,
                style: body1,
              )),
            ],
          ),
        ),
        const SizedBox(height: 36),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33),
          child: Text(
            "Directions",
            textAlign: TextAlign.left,
            style: title3,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 300,
          child: CustomMap(lat: museum.latitude, lng: museum.longitude),
        ),
      ],
    );
  }
}
