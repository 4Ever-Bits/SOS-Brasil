import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart' hide Color;

Positioned buildMarker(Color color) {
  return Positioned(
    child: Align(
      alignment: Alignment.center,
      child: Icon(
        Icons.location_on,
        color: color,
        size: 40,
      ),
    ),
  );
}

Padding buildSearch(BuildContext context, Function onSelected) {
  return Padding(
    padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
    child: MapBoxPlaceSearchWidget(
      popOnSelect: false,
      apiKey: DotEnv().env["MAPBOX_API_KEY"],
      limit: 10,
      language: "pt",
      searchHint: 'Localização',
      onSelected: onSelected,
      context: context,
      country: "br",
    ),
  );
}

Widget buildFAB(Function onClick, Color color) {
  return Positioned(
    right: 10,
    bottom: kBottomNavigationBarHeight + 40,
    child: FloatingActionButton(
      child: Icon(Icons.gps_fixed),
      onPressed: onClick,
      backgroundColor: color,
    ),
  );
}
