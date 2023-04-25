import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../view/map/map_screen.dart';

class MarkersProvider extends ChangeNotifier {
  List<Marker> markers = [
    Marker(
        point: LatLng(location.latitude, location.longitude),
        builder: (context) => const Icon(
              Icons.pin_drop_sharp,
              color: Colors.red,
              size: 40,
            )),
  ];

  List<Marker> get markersList => markers;

  void addMarkers(double lat, double long) {
    markersList.add(
      Marker(
        point: LatLng(lat, long),
        builder: (context) => const Icon(
          Icons.pin_drop_sharp,
          color: Colors.blue,
          size: 40,
        ),
      ),
    );
    notifyListeners();
  }
}
