import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Myloc extends StatelessWidget {
  const Myloc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: content(),
    );
  }
}

Widget content() {
  return FlutterMap(
    options: MapOptions(
      initialCenter: LatLng(8.8932, 76.6141),
      initialZoom: 15,
      interactionOptions:
          const InteractionOptions(flags: ~InteractiveFlag.doubleTapDragZoom),
    ),
    children: [
      openStreetMapTileLayer,
      const MarkerLayer(
        markers: [
          Marker(
            point: LatLng(8.8932, 76.6150),
            width: 60,
            height: 60,
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.location_pin,
              size: 60,
              color: Colors.red,
            ),
          ),
          Marker(
            point: LatLng(8.8932, 76.6141),
            width: 60,
            height: 60,
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.location_pin,
              size: 60,
              color: Colors.red,
            ),
          ),
          Marker(
            point: LatLng(8.8932, 76.6162),
            width: 60,
            height: 60,
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.location_pin,
              size: 60,
              color: Colors.red,
            ),
          ),
        ],
      ),
    ],
  );
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
