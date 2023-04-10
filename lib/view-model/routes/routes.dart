import 'package:flutter/material.dart';

import '../../view/screens/authentication/authentication_screen.dart';
import '../../view/screens/map/map_screen.dart';
import '../../view/screens/splash_screen.dart';

import 'named_routes.dart';

class Routes {
  static Map<String, WidgetBuilder> all(BuildContext context) {
    return {
      NamedRoutes.splash: (context) => const SplashScreen(),
      NamedRoutes.auth: (context) => const AuthenticationScreen(),
      NamedRoutes.map: (context) => const MapScreen(),
    };
  }
}
