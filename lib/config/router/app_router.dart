import 'package:flutter/widgets.dart';
import 'package:notification/presentation/screens/home_screen.dart';
import 'package:notification/presentation/screens/prueba.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  '/': (_) => HomeScreen(),
  'prueba': (_) => Prueba(),
};
