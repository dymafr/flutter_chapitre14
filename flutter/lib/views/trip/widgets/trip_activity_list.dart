import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/activity_model.dart';
import '../../../providers/trip_provider.dart';

class TripActivityList extends StatelessWidget {
  const TripActivityList({
    required this.tripId,
    required this.filter,
    super.key,
  });

  final String tripId;
  final ActivityStatus filter;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<Activity> activities = context
        .select<TripProvider, List<Activity>>(
          (TripProvider trips) => trips
              .getById(tripId)
              .activities
              .where((Activity activity) => activity.status == filter)
              .toList(growable: false),
        );

    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (BuildContext context, int index) {
        final Activity activity = activities[index];
        final Widget card = Card(
          child: ListTile(
            title: Text(
              activity.name,
              style: filter == ActivityStatus.done
                  ? TextStyle(color: theme.colorScheme.onSurfaceVariant)
                  : null,
            ),
          ),
        );
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: filter == ActivityStatus.done
              ? card
              : Dismissible(
                  key: ValueKey<String>(
                    activity.id ?? '${activity.city}/${activity.name}',
                  ),
                  direction: DismissDirection.endToStart,
                  background: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.colorScheme.primaryContainer,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Icon(
                          Icons.check,
                          size: 30,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                  confirmDismiss: (DismissDirection _) {
                    final TripProvider trips = context.read<TripProvider>();
                    return trips
                        .updateTrip(trips.getById(tripId), activity.id!)
                        .then((_) => true)
                        .catchError((_) => false);
                  },
                  child: card,
                ),
        );
      },
    );
  }
}
