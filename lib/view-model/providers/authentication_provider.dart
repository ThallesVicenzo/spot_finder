import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../routes/named_routes.dart';

class AuthenticationProvider with ChangeNotifier {
  Future<void> signInWithFacebook(context) async {
    FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]).then((value) {
      FacebookAuth.instance.getUserData().then((userData) {
        Navigator.pushNamed(context, NamedRoutes.map);
      });
    });
  }
}
