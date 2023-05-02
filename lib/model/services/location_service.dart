import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getPosition() async {
    return await Geolocator.getCurrentPosition();
  }
}
