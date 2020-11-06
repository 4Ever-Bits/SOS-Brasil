import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:SOS_Brasil/models/call.dart';

import 'package:SOS_Brasil/controllers/location_controller.dart';

import 'package:SOS_Brasil/components/snackbar.dart';

import 'package:SOS_Brasil/screens/ServiceCallScreen/components/ServiceScreen/build_methods.dart';
import 'package:SOS_Brasil/screens/ServiceCallScreen/components/ServiceScreen/fields.dart';
import 'package:SOS_Brasil/screens/ServiceCallScreen/components/ServiceScreen/service_form.dart';

import 'package:SOS_Brasil/screens/MapScreen/map_screen.dart';
import 'package:SOS_Brasil/screens/ServiceCallScreen/service_personalchoose_screen.dart';

class ServiceScreen extends StatefulWidget {
  final Color color;
  final String title;
  final int userId;
  final String url;
  final Map<String, double> location;

  const ServiceScreen(
      {Key key, this.color, this.title, this.location, this.userId, this.url})
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
  double _latitude;
  double _longitude;

  File imageFile;
  File audioFile;

  @override
  void initState() {
    _latitude = widget.location["latitude"];
    _longitude = widget.location["longitude"];

    _locationFieldControlller =
        TextEditingController(text: "Minha localização atual");

    super.initState();
  }

  handleLocationFabClick() async {
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
      _locationFieldControlller.text = "Localização personalizada";
    }

    setState(() {
      _latitude = latitude;
      _longitude = longitude;
    });
  }

  handleTitleField(newValue) {
    setState(() {
      _title = newValue;
    });
  }

  handleDescriptionField(newValue) {
    setState(() {
      _description = newValue;
    });
  }

  handleTakePhoto() async {
    try {
      ImagePicker picker = ImagePicker();

      var picture = await picker.getImage(source: ImageSource.camera);

      setState(() {
        imageFile = File(picture.path);
      });

      CustomSnackbar.showFileSaveSuccess(context);
    } catch (e) {
      CustomSnackbar.showFileError(context);
    }
  }

  audioCallback(File file) {
    setState(() {
      audioFile = file;
    });
  }

  handleNextButtonClick() async {
    bool isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();

      if (_title.isNotEmpty &&
          _description.isNotEmpty &&
          _latitude != null &&
          _longitude != null) {
        Call call = Call(
          title: _title,
          description: _description,
          latitude: _latitude,
          longitude: _longitude,
          imageFile: imageFile,
          audioFile: audioFile,
          userId: widget.userId,
        );

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PersonalChooseScreen(
            call: call,
            color: widget.color,
            url: widget.url,
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      body: ServiceForm(
        context: context,
        formKey: _formKey,
        children: <Widget>[
          buildTitle(widget.title),
          TitleField(
            onSaved: handleTitleField,
          ),
          DescriptionField(
            color: widget.color,
            onSaved: handleDescriptionField,
            cbAudio: audioCallback,
            takePhoto: handleTakePhoto,
          ),
          LocationField(
            color: widget.color,
            onClick: handleLocationFabClick,
            controller: _locationFieldControlller,
          ),
          SizedBox(height: 10),
          buildNextButton(context, handleNextButtonClick),
          buildCloseBar(context),
        ],
      ),
    );
  }
}
