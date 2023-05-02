import 'package:geolocator/geolocator.dart';

class LocationModel {
  Future<Position> getPosition() async {
    return await Geolocator.getCurrentPosition();
  }
}
