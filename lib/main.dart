import 'package:flutter/material.dart';

import 'routes/named_routes.dart';
import 'routes/routes.dart';

void main() {
  // ChangeNotifierProvider(
  //   create: (context) => BooksRepository(),
  // );
  runApp(const MapHelper());
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
              fontSize: 20,
            )),
      ),
    );
  }
}
