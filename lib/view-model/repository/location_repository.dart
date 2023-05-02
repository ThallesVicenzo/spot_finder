import 'package:geolocator/geolocator.dart';

import '../../model/services/location.dart';

class LocationRepository {
  Future<Position> determinePosition() async {
    final location = LocationModel();

    return await location.getPosition();
  }
}
