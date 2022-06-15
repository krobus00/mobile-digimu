import 'package:digium/constants/theme.dart';
import 'package:digium/models/museum_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

class AboutTab extends StatelessWidget {
  final MuseumModel museum;

  AboutTab({
    Key? key,
    required this.museum,
  }) : super(key: key);
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
  @override
  Widget build(BuildContext context) {
    return Column(
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
          style: TextStyle(fontSize: 16),
        ),
        Spacer(),
        const Text(
          "Information",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.pin_drop,
                  color: primaryColor,
                ),
                Text(museum.address),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.phone_enabled_outlined,
                  color: primaryColor,
                ),
                Text(museum.phone),
              ],
            )
          ],
        ),
        Row(
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
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Container(
                    width: 100,
                    child: FlutterMap(
                      options: MapOptions(
                        center:
                            latLng.LatLng(museum.latitude, museum.longitude),
                        zoom: 13.0,
                      ),
                      layers: [
                        TileLayerOptions(
                            urlTemplate: "mapbox://styles/mapbox/streets-v11",
                            additionalOptions: {
                              'accessToken':
                                  'pk.eyJ1Ijoic2hpbnlxMTEiLCJhIjoiY2ptY3d3OGxsMTA1dDNsbnl4OXJ1cHpkeCJ9.7fp_UEinaxDc5l8kOT6nBw',
                              'id': 'mapbox.mapbox-streets-v8'
                            }),
                        MarkerLayerOptions(
                          markers: [
                            Marker(
                              width: 80.0,
                              height: 80.0,
                              point: latLng.LatLng(
                                  museum.latitude, museum.longitude),
                              builder: (ctx) => Container(
                                child: FlutterLogo(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            )

            // MapboxMap(
            //   accessToken:
            //       'pk.eyJ1Ijoic2hpbnlxMTEiLCJhIjoiY2ptY3d3OGxsMTA1dDNsbnl4OXJ1cHpkeCJ9.7fp_UEinaxDc5l8kOT6nBw',
            //   styleString: 'mapbox://styles/mapbox/streets-v11',
            //   initialCameraPosition: CameraPosition(
            //     zoom: 15.0,
            //     target: LatLng(museum.latitude, museum.longitude),
            //   ),
            // ),
          ],
        )
      ],
    );
  }
}
