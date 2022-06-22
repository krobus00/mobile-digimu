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
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            "About",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            museum.description,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          // const Spacer(),
          const Text(
            "Information",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.pin_drop,
                color: primaryColor,
              ),
              Flexible(child: Text(museum.address)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.phone_enabled_outlined,
                color: primaryColor,
              ),
              Flexible(child: Text(museum.phone)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Directions",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "see directions",
                style: TextStyle(color: primaryColor),
              ),
            ],
          ),

          Container(
            height: 300,
            color: Colors.red,
            child: CustomMap(lat: museum.latitude, lng: museum.longitude),
          ),
        ],
      ),
    );
  }
}
