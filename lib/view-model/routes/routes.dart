import 'package:flutter/material.dart';

import 'named_routes.dart';

import '../../view/authentication/authentication_screen.dart';
import '../../view/map/map_screen.dart';
import '../../view/splash_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> all(BuildContext context) {
    return {
      NamedRoutes.splash: (context) => const SplashScreen(),
      NamedRoutes.auth: (context) => const AuthenticationScreen(),
      NamedRoutes.map: (context) => const MapScreen(),
    };
  }
}
