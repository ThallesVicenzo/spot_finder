import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spot_finder/view-model/repository/location_repository.dart';

class LocationProvider with ChangeNotifier {
  double latitude = 0;
  double longitude = 0;

  final _locationRepository = LocationRepository();

  Future<String?> permissionsvalidate() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return null;
  }

  Future<Position?> getPosition() async {
    await permissionsvalidate().then((value) async {
      if (value == null) {
        Position position = await _locationRepository.determinePosition();
        longitude = position.longitude;
        latitude = position.latitude;
        return position;
      }
    });
    return null;
  }
}
