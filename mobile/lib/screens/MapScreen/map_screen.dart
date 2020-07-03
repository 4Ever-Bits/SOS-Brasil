import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart' hide Color;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          buildMap(),
          buildButton(),
          buildFAB(),
          buildMarker(),
          buildSearch(context),
        ],
      ),
    );
  }

  Positioned buildMarker() {
    return Positioned(
      child: Align(
        alignment: Alignment.center,
        child: Icon(
          Icons.location_on,
          color: widget.color,
          size: 40,
        ),
      ),
    );
  }

  Padding buildSearch(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
      child: MapBoxPlaceSearchWidget(
        popOnSelect: false,
        apiKey:
            "pk.eyJ1IjoicGgtZm1tIiwiYSI6ImNrYzN4dnhleTAyaTQyeW85N202aDJ2ZzIifQ.fZH-H487byxBzR5KCSB0tg",
        limit: 10,
        language: "pt",
        searchHint: 'Localização',
        onSelected: (place) {
          double longitude = place.geometry.coordinates.first;
          double latitude = place.geometry.coordinates.last;
          String strCoords = place.placeName;

          controller.move(LatLng(latitude, longitude), 17);

          setState(() {
            latitude = latitude;
            longitude = longitude;
            strcoords = strCoords;
          });
        },
        context: context,
        country: "br",
      ),
    );
  }

  Positioned buildFAB() {
    return Positioned(
      right: 10,
      bottom: kBottomNavigationBarHeight + 40,
      child: FloatingActionButton(
        child: Icon(Icons.gps_fixed),
        onPressed: () {
          controller.move(LatLng(widget.latitude, widget.longitude), 17);
        },
      ),
    );
  }

  Container buildMap() {
    return Container(
      child: FlutterMap(
        mapController: controller,
        options: MapOptions(
          center: LatLng(widget.latitude, widget.longitude),
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
                point: LatLng(widget.latitude, widget.longitude),
                builder: (ctx) => Container(
                  child: Icon(
                    Icons.person_pin,
                    size: 32,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Positioned buildButton() {
    return Positioned(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: Colors.black45,
                  offset: Offset(0, 3),
                )
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: FlatButton(
              color: widget.color,
              child: Text(
                "Pronto",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  letterSpacing: 5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () {
                print(controller.center);
                String strCoords = controller.center.latitude.toString() +
                    ", " +
                    controller.center.longitude.toString();

                Map<String, dynamic> data = {
                  "latitude": controller.center.latitude,
                  "longitude": controller.center.longitude,
                  "strCoords": strcoords
                };

                Navigator.of(context).pop(data);
              },
            ),
          ),
        ),
      ),
    );
  }
}
