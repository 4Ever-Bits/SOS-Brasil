import 'package:flutter/material.dart';

class LocationFAB extends StatelessWidget {
  const LocationFAB({
    Key key,
    @required this.color,
    @required this.onClick,
  }) : super(key: key);

  final Color color;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "location",
      elevation: 0,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.location_on,
        color: color,
        size: 32,
      ),
      onPressed: onClick,
    );
  }
}

class PhotoFAB extends StatelessWidget {
  const PhotoFAB({
    Key key,
    @required this.color,
    @required this.takePhoto,
  }) : super(key: key);

  final Color color;
  final Function takePhoto;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "photo",
      elevation: 0,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.camera_alt,
        color: color,
        size: 32,
      ),
      onPressed: takePhoto,
    );
  }
}

class AudioFAB extends StatelessWidget {
  const AudioFAB({
    Key key,
    @required this.color,
    @required this.recordAudio,
  }) : super(key: key);

  final Color color;
  final Function recordAudio;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "audio",
      elevation: 0,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.keyboard_voice,
        color: color,
        size: 32,
      ),
      onPressed: recordAudio,
    );
  }
}
