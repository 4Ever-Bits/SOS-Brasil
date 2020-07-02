import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart'
    hide Location, Color;

class MapScreen extends StatefulWidget {
  final double latitude, longitude;
  final Color color;

  MapScreen({Key key, this.latitude, this.longitude, this.color})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Location location = Location();
  MapController controller = MapController();

  double latitude, longitude;

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
          Positioned(
            child: Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.location_on,
                color: widget.color,
                size: 40,
              ),
            ),
          ),
          buildSerach(context),
        ],
      ),
    );
  }

  Padding buildSerach(BuildContext context) {
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

          controller.move(LatLng(latitude, longitude), 17);

          setState(() {
            latitude = latitude;
            longitude = longitude;
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
          // MarkerLayerOptions(
          //   markers: [
          //     Marker(
          //       width: 80.0,
          //       height: 80.0,
          //       point: LatLng(widget.latitude, widget.longitude),
          //       builder: (ctx) => Container(
          //         child:
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Positioned buildSearch() {
    return Positioned(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: Colors.black45,
                  offset: Offset(0, 3),
                )
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => MapBoxAutoCompleteWidget(
                //       apiKey:
                //           "pk.eyJ1IjoicGgtZm1tIiwiYSI6ImNrYzN4dnhleTAyaTQyeW85N202aDJ2ZzIifQ.fZH-H487byxBzR5KCSB0tg",
                //       hint: "Select starting point",
                //       onSelect: (place) {
                //         // TODO : Process the result gotten
                //         // _startPointController.text = place.placeName;
                //       },
                //       limit: 10,
                //     ),
                //   ),
                // );
              },
            ),
          ),
        ),
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
                Navigator.of(context).pop(strCoords);
              },
            ),
          ),
        ),
      ),
    );
  }
}
