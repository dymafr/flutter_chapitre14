import 'package:flutter/material.dart';

import '../../models/city_model.dart';
import '../../models/trip_model.dart';
import 'widgets/trip_activities.dart';
import 'widgets/trip_city_bar.dart';
import 'widgets/trip_weather.dart';

class TripRouteArguments {
  const TripRouteArguments({required this.tripId, required this.cityName});

  final String tripId;
  final String cityName;
}

class TripView extends StatelessWidget {
  const TripView({required this.trip, required this.city, super.key});

  static const String routeName = '/trip';

  final Trip trip;
  final City city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TripCityBar(city: city),
            TripWeather(cityName: city.name),
            TripActivities(tripId: trip.id!),
          ],
        ),
      ),
    );
  }
}
