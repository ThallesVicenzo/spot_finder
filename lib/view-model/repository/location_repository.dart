import 'package:geolocator/geolocator.dart';

import '../../model/services/location_service.dart';

class LocationRepository {
  Future<Position> determinePosition() async {
    final location = LocationService();

    return await location.getPosition();
  }
}
