import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'shared/theme.dart';
import 'view-model/providers/authentication_provider.dart';
import 'view-model/providers/markers_provider.dart';
import 'view-model/providers/save_spot_provider.dart';
import 'view-model/routes/named_routes.dart';
import 'view-model/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MarkersProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => SaveSpotProvider())
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
      theme: AppTheme.defaultTheme,
    );
  }
}
