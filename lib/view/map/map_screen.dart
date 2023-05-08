import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../view-model/providers/map_providers/location_provider.dart';
import '../../view-model/providers/map_providers/markers_provider.dart';
import '../../view/map/loading_screen.dart';

import '../../shared/constants.dart';
import 'widgets/save_spot.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MarkersProvider markersProvider;
  late LocationProvider locationProvider;

  @override
  void didChangeDependencies() {
    locationProvider = Provider.of<LocationProvider>(context);
    markersProvider = Provider.of<MarkersProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
          future: locationProvider.getPosition(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            }
            return Column(
              children: [
                Flexible(
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(locationProvider.latitude,
                          locationProvider.longitude),
                      zoom: 18.0,
                      onTap: (tapPosition, point) {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 70,
                                ),
                                child: SaveSpot(),
                              );
                            });
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/{z}/{x}/{y}?access_token=$kAccessToken",
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: markersProvider.getMarkersList(context),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
