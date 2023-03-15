import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/activity_model.dart';
import '../../../models/trip_model.dart';
import '../../../providers/trip_provider.dart';

class TripActivityList extends StatelessWidget {
  final String tripId;
  final ActivityStatus filter;

  const TripActivityList({super.key, required this.tripId, required this.filter});

  @override
  Widget build(BuildContext context) {
    final Trip trip = Provider.of<TripProvider>(context).getById(tripId);
    final List<Activity> activities =
    trip.activities.where((activity) => activity.status == filter).toList();
    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, i) {
        final Activity activity = activities[i];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: filter == ActivityStatus.ongoing
              ? Dismissible(
            direction: DismissDirection.endToStart,
            background: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.greenAccent[700],
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 30,
              ),
            ),
            key: ValueKey(activity.id),
            child: Card(
              child: ListTile(
                title: Text(activity.name),
              ),
            ),
            confirmDismiss: (_) =>
                Provider.of<TripProvider>(context, listen: false)
                    .updateTrip(trip, activity.id!)
                    .then((_) => true)
                    .catchError((_) => false),
          )
              : Card(
            child: ListTile(
              title: Text(
                activity.name,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}