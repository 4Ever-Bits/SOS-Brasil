import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class GeoMap extends StatelessWidget {
  final MapController controller;
  final double latitude;
  final double longitude;
  final Color color;

  const GeoMap(
      {Key key,
      @required this.controller,
      @required this.latitude,
      @required this.longitude,
      @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: controller,
      options: MapOptions(
        center: LatLng(latitude, longitude),
        zoom: 17,
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
              point: LatLng(latitude, longitude),
              builder: (ctx) => Container(
                child: Icon(
                  Icons.person_pin,
                  size: 32,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
