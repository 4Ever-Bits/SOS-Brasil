import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';

import 'package:SOS_Brasil/utils/server_url.dart';

class ServiceController {
  final Map<String, double> _manausCoord = {
    "maxLat": -2.95,
    "minLat": -3.16,
    "maxLong": -59.9,
    "minLong": -60.1
  };

  final Map<String, String> _manausUrl = {
    "ambulance": serviceServerUrl,
    "police": serviceServerUrl,
    "firedep": serviceServerUrl,
  };

  bool compareCoordinates(Location location, Map<String, double> city) {
    if (location.lat < city["maxLat"] && location.lat > city["minLat"]) {
      if (location.lng < city["maxLong"] && location.lng > city["minLong"])
        return true;
    }
    return false;
  }

  Map<String, String> getUrl(double latitude, double longitude) {
    Location currentLocation = Location(lat: latitude, lng: longitude);

    //Compare for Manaus only
    if (compareCoordinates(currentLocation, _manausCoord))
      return _manausUrl;
    else
      throw new Exception("Invalid coordinates");
  }
}
