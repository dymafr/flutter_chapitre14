import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/city_model.dart';
import 'models/trip_model.dart';
import 'providers/trip_provider.dart';
import 'providers/city_provider.dart';
import 'views/city/city_view.dart';
import 'views/trips/trips_view.dart';
import 'views/not-found/not_found.dart';
import 'views/trip/trip_view.dart';
import 'views/activity_form/activity_form_view.dart';
import './views/home/home_view.dart';

void main() {
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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const HomeView(),
          CityView.routeName: (_) => const CityView(),
          TripsView.routeName: (_) => const TripsView(),
          ActivityFormView.routeName: (_) => const ActivityFormView(),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name != TripView.routeName) return null;
          final Object? arguments = settings.arguments;
          if (arguments is! TripRouteArguments) {
            throw ArgumentError.value(
              arguments,
              'settings.arguments',
              'Un objet TripRouteArguments est requis pour /trip.',
            );
          }
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (BuildContext context) {
              final Trip trip = context.read<TripProvider>().getById(
                arguments.tripId,
              );
              final City city = context.read<CityProvider>().getCityByName(
                arguments.cityName,
              );
              return TripView(trip: trip, city: city);
            },
          );
        },
        onUnknownRoute: (_) =>
            MaterialPageRoute(builder: (_) => const NotFound()),
      ),
    );
  }
}
