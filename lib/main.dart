import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/providers/weather_provider.dart';
import 'screens/my_app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MyApp(),
    ),
  );
}
