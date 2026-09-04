import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/trip_model.dart';
import '../../trip/trip_view.dart';

class TripList extends StatelessWidget {
  const TripList({super.key, required this.trips});

  final List<Trip> trips;

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) {
      return const Center(child: Text('Aucun voyage enregistré.'));
    }

    return ListView.builder(
      itemCount: trips.length,
      itemBuilder: (BuildContext context, int index) {
        final Trip trip = trips[index];
        final DateTime? date = trip.date;

        return ListTile(
          title: Text(trip.city),
          subtitle: date == null
              ? null
              : Text(DateFormat('d/M/y').format(date)),
          trailing: const Icon(Icons.info),
          onTap: () {
            Navigator.pushNamed<void>(
              context,
              TripView.routeName,
              arguments: TripRouteArguments(
                tripId: trip.id!,
                cityName: trip.city,
              ),
            );
          },
        );
      },
    );
  }
}
