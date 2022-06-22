import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class CustomMap extends StatelessWidget {
  final double lat;
  final double lng;
  const CustomMap({Key? key, required this.lat, required this.lng})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(lat, lng),
        zoom: 16.0,
        minZoom: 16.0,
        allowPanning: false,
        allowPanningOnScrollingParent: false,
        enableScrollWheel: false,
        enableMultiFingerGestureRace: false,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(lat, lng),
              builder: (ctx) => const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 45,
              ),
            ),
          ],
        ),
      ],
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'OpenStreetMap contributors',
          onSourceTapped: () {},
        ),
      ],
    );
  }
}
