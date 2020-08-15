import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'package:mobile/screens/MapScreen/components/build_methods.dart';
import 'package:mobile/screens/MapScreen/components/geomap.dart';
import 'package:mobile/screens/MapScreen/components/submit_button.dart';

class MapScreen extends StatefulWidget {
  final double latitude, longitude;
  final Color color;

  MapScreen({Key key, this.latitude, this.longitude, this.color})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController controller = MapController();

  double latitude, longitude;
  String strcoords;

  @override
  void initState() {
    latitude = widget.latitude;
    longitude = widget.longitude;
    super.initState();
  }

  handleSearch(place) {
    double longitude = place.geometry.coordinates.first;
    double latitude = place.geometry.coordinates.last;
    String strCoords = place.placeName;

    controller.move(LatLng(latitude, longitude), 17);

    setState(() {
      latitude = latitude;
      longitude = longitude;
      strcoords = strCoords;
    });
  }

  handleSubmit() {
    Map<String, dynamic> data = {
      "latitude": controller.center.latitude,
      "longitude": controller.center.longitude,
      "strCoords": strcoords
    };

    Navigator.of(context).pop(data);
  }

  handleReturnToMyLocation() {
    controller.move(LatLng(widget.latitude, widget.longitude), 17);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GeoMap(
            controller: controller,
            latitude: widget.latitude,
            longitude: widget.longitude,
            color: widget.color,
          ),
          SubmitButton(
            color: widget.color,
            onClick: handleSubmit,
          ),
          buildFAB(handleReturnToMyLocation, widget.color),
          buildMarker(widget.color),
          buildSearch(context, handleSearch),
        ],
      ),
    );
  }
}
