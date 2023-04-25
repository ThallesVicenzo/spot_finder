import 'dart:async';

import 'package:flutter/material.dart';

import '../../view-model/routes/named_routes.dart';
import '../shared/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  double opacity = 1;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 2500), () {
      setState(() {
        opacity = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).splashColor,
      body: AnimatedOpacity(
        opacity: opacity,
        duration: kThemeAnimationDuration,
        onEnd: () {
          if (opacity == 0) {
            Navigator.pushReplacementNamed(context, NamedRoutes.auth);
          }
        },
        child: Center(
          child: Image.asset(kMapIcon),
        ),
      ),
    );
  }
}
