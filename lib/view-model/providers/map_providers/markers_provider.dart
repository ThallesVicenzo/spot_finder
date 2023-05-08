import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import 'location_provider.dart';

class MarkersProvider extends ChangeNotifier {
  List<Marker> getMarkersList(context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    double latitude = locationProvider.latitude;
    double longitude = locationProvider.longitude;
    List<Marker> markers = [
      Marker(
          point: LatLng(latitude, longitude),
          builder: (context) => const Icon(
                Icons.pin_drop_sharp,
                color: Colors.red,
                size: 40,
              )),
    ];
    return markers;
  }

  // void addMarkers(double lat, double long, context) {
  //   getMarkersList(context).add(
  //     Marker(
  //       point: LatLng(lat, long),
  //       builder: (context) => Icon(
  //         Icons.pin_drop_sharp,
  //         color: Provider.of<SaveSpotProvider>(context).currentColor,
  //         size: 40,
  //       ),
  //     ),
  //   );
  //   notifyListeners();
  // }
}
