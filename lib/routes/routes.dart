import 'package:flutter/material.dart';

import '../screens/authentication/authentication.dart';
import '../screens/splash_screen.dart';
import 'named_routes.dart';

class Routes {
  static Map<String, WidgetBuilder> all(BuildContext context) {
    return {
      NamedRoutes.splash: (context) => const SplashScreen(),
      NamedRoutes.auth: (context) => AuthenticationScreen(),
    };
  }
}
