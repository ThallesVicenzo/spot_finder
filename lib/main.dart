import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_finder/view-model/providers/authentication_provider.dart';
// import 'package:spot_finder/view-model/providers/camera_provider.dart';
import 'package:spot_finder/view-model/providers/markers_provider.dart';

import 'view-model/providers/custom_text_field_provider.dart';
import 'view-model/routes/named_routes.dart';
import 'view-model/routes/routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MarkersProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        // ChangeNotifierProvider(create: (_) => CameraProvider())
        ChangeNotifierProvider(create: (_) => TextFieldProvider())
      ],
      child: const MapHelper(),
    ),
  );
}

class MapHelper extends StatelessWidget {
  const MapHelper({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: NamedRoutes.splash,
      routes: Routes.all(context),
      theme: ThemeData(
        primaryColor: const Color(0xFF11159A),
        primaryTextTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Color(0xFF11159A),
            fontSize: 50,
          ),
          bodyMedium: TextStyle(
            color: Color(0xFF11159A),
            fontSize: 30,
          ),
          bodySmall: TextStyle(
            color: Color(0xFF11159A),
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
