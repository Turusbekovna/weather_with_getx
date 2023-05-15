import 'package:flutter/material.dart';
// import 'package:weather_app/views/home_view.dart';
// import 'package:weather_app/views/test_future.dart';
import 'package:weather_with_getx/views/home_view.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeView());
  }
}
