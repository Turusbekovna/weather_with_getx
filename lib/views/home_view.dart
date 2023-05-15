import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:weather_app/views/search_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_with_getx/views/search_view.dart';

import '../constants/api_keys/api.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

dynamic getDescription(dynamic _temp) {
  if (_temp > 25) {
    return 'Чаңкайсың го, жарыгым';
  } else if (_temp > 20) {
    return 'Жыргал заман ';
  } else if (_temp < 10) {
    return 'Үшүп калба 🧣 🧤';
  } else {
    return 'Калың кийин';
  }
}

class _HomeViewState extends State<HomeView> {
  String cityName = '';
  dynamic tempreture = '';
  bool isLoading = false;
  String country = '';
  dynamic description;

  @override
  void initState() {
    showWeatherByLocation();
    super.initState();
  }

  Future<void> showWeatherByLocation() async {
    final position = await _getPosition();
    await getWeather(position);
    // log('latitude ==> ${position.latitude}');
    // log('longitude ==> ${position.longitude}');

    // Alt+Shift+PageUp \\ PageDown
    // Ctrl+X = Ochurot
    // Ctrl+D
  }

  Future<void> getWeather(Position position) async {
    setState(() {
      isLoading = true;
    });
    try {
      final client = http.Client();
      final url =
          'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=${ApiKeys.myApiKey}';
      Uri uri = Uri.parse(url);
      final joop = await client.get(uri);
      final jsonJoop = jsonDecode(joop.body);
      cityName = jsonJoop['name'];
      final double kelvin = jsonJoop['main']['temp'];
      tempreture = (kelvin - 273.15).toStringAsFixed(0);
      description = getDescription(tempreture);
      setState(() {
        isLoading = false;
      });

      log('respons ==> ${joop.body}');
      log('respons ==> ${jsonJoop}');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getSearchedCityName(String typedCityName) async {
    final client = http.Client();
    try {
      Uri uri = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$typedCityName&appid=${ApiKeys.myApiKey}');
      final response = await client.get(uri);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('data ===> ${response.body}');
        final data = jsonDecode(response.body);
        log('data ===> ${data}');
        cityName = data['name'];
        country = data['sys']['country'];
        final double kelvin = data['main']['temp'];
        tempreture = (kelvin - 273.15).toStringAsFixed(0);
        setState(() {});
      }
    } catch (e) {}
  }

  Future<Position> _getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () async {
              await showWeatherByLocation();
            },
            child: Icon(Icons.near_me, size: 50),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchView()),
                );
              },
              child: Icon(
                Icons.location_city,
                size: 50,
              ),
            )
          ],
        ),
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_image_jpg.jpg'),
                  fit: BoxFit.cover),
            ),
            child: isLoading == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                      backgroundColor: Colors.green,
                    ),
                  )
                : Stack(
                    children: [
                      Positioned(
                        top: 100,
                        left: 170,
                        child: Text(
                          '⛅',
                          style: TextStyle(fontSize: 60, color: Colors.white),
                        ),
                      ),
                      Positioned(
                        top: 130,
                        left: 40,
                        child: Text(
                          '$tempreture\u2103',
                          style: TextStyle(fontSize: 90, color: Colors.white),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 40,
                        child: Text(
                          'Country: $country ',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 330,
                        left: 60,
                        child: Text(
                          description ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      ),
                      Positioned(
                        top: 320,
                        // left: ,
                        right: 0,
                        child: Text(
                          '👚',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 500,
                        left: 40,
                        child: Text(
                          cityName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  )),
      ),
    );
  }
}
