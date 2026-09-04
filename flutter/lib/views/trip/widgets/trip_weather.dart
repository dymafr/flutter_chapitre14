import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../widgets/dyma_loader.dart';

class TripWeather extends StatefulWidget {
  final String cityName;

  const TripWeather({super.key, required this.cityName});

  @override
  State<TripWeather> createState() => _TripWeatherState();
}

class _TripWeatherState extends State<TripWeather> {
  static const String apiKey = String.fromEnvironment('OPENWEATHERMAP_KEY');

  late final Future<String> weather;

  @override
  void initState() {
    super.initState();
    weather = fetchIconName();
  }

  Future<String> fetchIconName() async {
    final http.Response response = await http.get(
      Uri.https('api.openweathermap.org', '/data/2.5/weather', {
        'q': widget.cityName,
        'appid': apiKey,
      }),
    );
    final Map<String, dynamic> body =
        json.decode(response.body) as Map<String, dynamic>;
    return body['weather'][0]['icon'] as String;
  }

  String getIconUrl(String iconName) =>
      'https://openweathermap.org/img/wn/$iconName@2x.png';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: weather,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const DymaLoader();
        }
        if (snapshot.hasError) {
          return const Text('Météo indisponible');
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text('Météo', style: TextStyle(fontSize: 20)),
              Image.network(getIconUrl(snapshot.data!), width: 50, height: 50),
            ],
          ),
        );
      },
    );
  }
}
