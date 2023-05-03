import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../routes/named_routes.dart';

class AuthenticationProvider with ChangeNotifier {
  bool disable = false;

  void disableButtons() {
    disable = !disable;
    notifyListeners();
  }

  Future<void> signInWithFacebook(context) async {
    disableButtons();
    FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]).then((value) {
      FacebookAuth.instance.getUserData().then((userData) {
        disableButtons();

        Navigator.pushNamed(context, NamedRoutes.map);
      });
    });
    disableButtons();
  }
}
