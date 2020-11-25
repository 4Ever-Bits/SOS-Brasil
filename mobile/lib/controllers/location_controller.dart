import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController {
  Location location;

  LocationController() {
    location = new Location();
  }

  Future<Map<String, double>> getCurrentLocation() async {
    bool hasPermission = await Permission.location.isGranted;

    if (hasPermission) {
      LocationData currentLocationData = await location.getLocation();

      Map<String, double> currentLocation = {
        "latitude": currentLocationData.latitude,
        "longitude": currentLocationData.longitude
      };

      return currentLocation;
    } else
      throw Exception("Need permission");
  }
}
