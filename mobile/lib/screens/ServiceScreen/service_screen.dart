import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mobile/controllers/location_controller.dart';
import 'package:mobile/screens/MapScreen/map_screen.dart';
import 'package:mobile/screens/ServiceScreen/service_personalchoose_screen.dart';

import 'package:mobile/components/snackbar.dart';

import 'package:mobile/models/call.dart';

class ServiceScreen extends StatefulWidget {
  final Color color;
  final String title;
  final Map<String, double> location;

  const ServiceScreen({Key key, this.color, this.title, this.location})
      : super(key: key);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LocationController locationController = LocationController();
  TextEditingController _locationFieldControlller;

  String _title;
  String _description;
  String _coordinatePlace;
  double _latitude;
  double _longitude;

  File imageFile;

  @override
  void initState() {
    _latitude = widget.location["latitude"];
    _longitude = widget.location["longitude"];

    _locationFieldControlller =
        TextEditingController(text: "Minha localização atual");

    super.initState();
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
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buildTitle(),
                  buildFirstField(),
                  buildSecondField(),
                  buildThirdField(),
                  SizedBox(height: 10),
                  buildNextButton(),
                  buildCloseBar(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildCloseBar(BuildContext context) {
    return Container(
      height: 32,
      child: Center(
        child: Divider(
          color: Colors.white,
          thickness: 1,
          indent: (MediaQuery.of(context).size.width / 2) - 50,
          endIndent: (MediaQuery.of(context).size.width / 2) - 50,
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text(
        "Deseja chamar ${widget.title}?",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25, color: Colors.white),
      ),
    );
  }

  GestureDetector buildNextButton() {
    return GestureDetector(
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
          onPressed: () async {
            bool isValid = _formKey.currentState.validate();

            if (isValid) {
              _formKey.currentState.save();

              if (_title.isNotEmpty &&
                  _description.isNotEmpty &&
                  _latitude != null &&
                  _longitude != null) {
                print("$_title\n$_description\n$_latitude, $_longitude");

                Call call = Call(
                  title: _title,
                  description: _description,
                  latitude: _latitude,
                  longitude: _longitude,
                  imageFile: imageFile,
                );

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PersonalChooseScreen(
                    call: call,
                    color: widget.color,
                  ),
                ));
              }
            }
          },
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
            onSaved: (newValue) {
              setState(() {
                _title = newValue;
              });
            },
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
                  onSaved: (newValue) {
                    setState(() {
                      _description = newValue;
                    });
                  },
                ),
              ),
              Column(
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: "audio",
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
                    heroTag: "photo",
                    elevation: 0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.camera_alt,
                      color: widget.color,
                      size: 32,
                    ),
                    onPressed: () async {
                      try {
                        ImagePicker picker = ImagePicker();

                        var picture =
                            await picker.getImage(source: ImageSource.camera);

                        setState(() {
                          imageFile = File(picture.path);
                        });

                        CustomSnackbar.showFileSaveSuccess(context);
                      } catch (e) {
                        CustomSnackbar.showFileError(context);
                      }
                    },
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
                  enabled: false,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                ),
              ),
              FloatingActionButton(
                heroTag: "location",
                elevation: 0,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.location_on,
                  color: widget.color,
                  size: 32,
                ),
                onPressed: () async {
                  Map<String, dynamic> data = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        latitude: _latitude,
                        longitude: _longitude,
                        color: widget.color,
                      ),
                    ),
                  );

                  double latitude = data["latitude"];
                  double longitude = data["longitude"];
                  String strCoords = data["strCoords"];

                  if (strCoords != null) {
                    _locationFieldControlller.text = strCoords;
                  } else if (latitude != _latitude && _longitude != longitude) {
                    _locationFieldControlller.text =
                        "Localização personalizada";
                  }

                  setState(() {
                    _latitude = latitude;
                    _longitude = longitude;
                    _coordinatePlace = strCoords;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
