import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/trip_provider.dart';
import 'providers/city_provider.dart';
import 'views/city/city_view.dart';
import 'views/trips/trips_view.dart';
import 'views/not-found/not_found.dart';
import 'views/trip/trip_view.dart';
import 'views/activity_form/activity_form_view.dart';
import './views/home/home_view.dart';

main() {
  runApp(const DymaTrip());
}

class DymaTrip extends StatefulWidget {
  const DymaTrip({super.key});

  @override
  State<DymaTrip> createState() => _DymaTripState();
}

class _DymaTripState extends State<DymaTrip> {
  final CityProvider cityProvider = CityProvider();
  final TripProvider tripProvider = TripProvider();

  @override
  void initState() {
    tripProvider.fetchData();
    cityProvider.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: cityProvider),
        ChangeNotifierProvider.value(value: tripProvider),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const HomeView(),
          CityView.routeName: (_) => const CityView(),
          TripsView.routeName: (_) => const TripsView(),
          TripView.routeName: (_) => const TripView(),
          ActivityFormView.routeName: (_) => const ActivityFormView(),
        },
        onUnknownRoute: (_) => MaterialPageRoute(
          builder: (_) => const NotFound(),
        ),
      ),
    );
  }
}