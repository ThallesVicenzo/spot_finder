import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:spot_finder/model/services/location.dart';
import 'package:spot_finder/view/screens/map/widgets/pop_up.dart';

import '../../../view-model/markers/markers.dart';
import '../../../view-model/shared/constants.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

final Location location = Location();
final MapController mapController = MapController();

Future<void> getLocation() async {
  return await location.determinePosition();
}

class _MapScreenState extends State<MapScreen> {
  MarkersProvider markersProvider = MarkersProvider();

  @override
  Widget build(BuildContext context) {
    //TODO: implement loading screen
    return Scaffold(
      body: FutureBuilder(
          initialData: getLocation(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Column(
              children: [
                Flexible(
                  child: ChangeNotifierProvider(
                    create: (_) => markersProvider,
                    child: Consumer<MarkersProvider>(
                      builder: (_, markersProvider, __) => FlutterMap(
                        options: MapOptions(
                          center: LatLng(location.latitude, location.longitude),
                          zoom: 18.0,
                          onTap: (tapPosition, point) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 70),
                                    child: PopUp(),
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
                            markers: markersProvider.markers,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
