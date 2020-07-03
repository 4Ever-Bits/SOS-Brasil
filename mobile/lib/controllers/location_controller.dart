import 'package:location/location.dart';

class LocationController {
  Location location;

  LocationController() {
    location = new Location();
  }

  Future<bool> getPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  Future<Map<String, double>> getCurrentLocation() async {
    bool hasPermission = await getPermission();

    if (hasPermission) {
      LocationData currentLocationData = await location.getLocation();

      // List<double> currentLocationList = [
      //   currentLocation.latitude,
      //   currentLocation.longitude
      // ];

      Map<String, double> currentLocation = {
        "latitude": currentLocationData.latitude,
        "longitude": currentLocationData.longitude
      };

      return currentLocation;
    } else
      throw Exception("Need permission");
  }
}
