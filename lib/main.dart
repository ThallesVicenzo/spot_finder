import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'shared/theme.dart';

import 'view-model/providers/map_providers/location_provider.dart';
import 'view-model/providers/map_providers/markers_provider.dart';
import 'view-model/providers/new_spot_providers/camera_provider.dart';
import 'view-model/providers/new_spot_providers/categories_provider.dart';
import 'view-model/routes/named_routes.dart';
import 'view-model/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MarkersProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => CameraProvider()),
      ],
      child: const SpotFinder(),
    ),
  );
}

class SpotFinder extends StatelessWidget {
  const SpotFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: NamedRoutes.splash,
      routes: Routes.all(context),
      theme: AppTheme.defaultTheme,
    );
  }
}
