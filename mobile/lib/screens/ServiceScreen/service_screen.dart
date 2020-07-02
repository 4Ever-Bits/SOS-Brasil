import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart'
    hide Location, Color;

import 'package:mobile/components/backdrop_close_bar.dart';
import 'package:mobile/screens/MapScreen/map_screen.dart';

class ServiceScreen extends StatefulWidget {
  final Color color;
  final String title;

  const ServiceScreen({Key key, this.color, this.title}) : super(key: key);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _locationFieldControlller;

  String _title;
  String _description;
  String _coordinatePlace;
  double _latitude;
  double _longitude;

  @override
  void initState() {
    getLocation().then((location) {
      print(location);
      double latitude = location.latitude;
      double longitude = location.longitude;

      //TODO Get place name from api
      // var reverseGeoCoding = ReverseGeoCoding(
      //   apiKey:
      //       "pk.eyJ1IjoicGgtZm1tIiwiYSI6ImNrYzN4dnhleTAyaTQyeW85N202aDJ2ZzIifQ.fZH-H487byxBzR5KCSB0tg",
      //   limit: 1,
      // );

      String text = latitude.toString() + ", " + longitude.toString();

      _locationFieldControlller = TextEditingController(text: text);

      setState(() {
        _latitude = latitude;
        _longitude = longitude;
      });
    });
    super.initState();
  }

  getLocation() async {
    try {
      Location location = new Location();

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      return await location.getLocation();
    } catch (e) {
      print(e);
    }
  }

  void verticalDrag(context, details) {
    if (details.delta.dy < -10) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Deseja chamar ${widget.title}?",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    buildFirstField(),
                    buildSecondField(),
                    buildThirdField(),
                    SizedBox(height: 20),
                    GestureDetector(
                      onVerticalDragUpdate: (details) {
                        verticalDrag(context, details);
                      },
                      child: Container(
                        width: 160,
                        height: 50,
                        child: OutlineButton(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Próximo",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          textColor: Colors.white,
                          borderSide: BorderSide(color: Colors.white),
                          highlightedBorderColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            CloseBar(),
          ],
        ),
      ),
    );
  }

  Padding buildFirstField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "O que aconteceu?",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildSecondField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Descrição",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: ((MediaQuery.of(context).size.width / 3) * 2) + 5,
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: "mama2",
                    elevation: 0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.keyboard_voice,
                      color: widget.color,
                      size: 32,
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(height: 8),
                  FloatingActionButton(
                    heroTag: "mama1",
                    elevation: 0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.camera_alt,
                      color: widget.color,
                      size: 32,
                    ),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Padding buildThirdField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Localização",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: (MediaQuery.of(context).size.width / 3) * 2,
                child: TextFormField(
                  controller: _locationFieldControlller,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                ),
              ),
              FloatingActionButton(
                heroTag: "mama",
                elevation: 0,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.location_on,
                  color: widget.color,
                  size: 32,
                ),
                onPressed: () async {
                  print(_latitude);
                  print(_longitude);
                  String strCoords = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        latitude: _latitude,
                        longitude: _longitude,
                        color: widget.color,
                      ),
                    ),
                  );

                  print(strCoords);

                  _locationFieldControlller.text = strCoords;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
