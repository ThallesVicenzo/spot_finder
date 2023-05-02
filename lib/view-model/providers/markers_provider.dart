import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:spot_finder/view-model/providers/location_provider.dart';
import 'package:spot_finder/view-model/providers/save_spot_provider.dart';

class MarkersProvider extends ChangeNotifier {
  List<Marker> getMarkersList(context) {
    double latitude = Provider.of<LocationProvider>(context).latitude;
    double longitude = Provider.of<LocationProvider>(context).longitude;
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

  void addMarkers(double lat, double long, context) {
    getMarkersList(context).add(
      Marker(
        point: LatLng(lat, long),
        builder: (context) => Icon(
          Icons.pin_drop_sharp,
          color: Provider.of<SaveSpotProvider>(context).currentColor,
          size: 40,
        ),
      ),
    );
    notifyListeners();
  }
}
