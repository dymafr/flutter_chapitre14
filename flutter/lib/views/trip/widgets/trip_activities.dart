import 'package:flutter/material.dart';

import '../../../models/activity_model.dart';
import 'trip_activity_list.dart';

class TripActivities extends StatelessWidget {
  const TripActivities({required this.tripId, super.key});

  final String tripId;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          ColoredBox(
            color: theme.colorScheme.primary,
            child: TabBar(
              labelColor: theme.colorScheme.onPrimary,
              unselectedLabelColor: theme.colorScheme.primaryContainer,
              indicatorColor: theme.colorScheme.onPrimary,
              tabs: const <Widget>[
                Tab(text: 'En cours'),
                Tab(text: 'Terminées'),
              ],
            ),
          ),
          SizedBox(
            height: 600,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                TripActivityList(
                  tripId: tripId,
                  filter: ActivityStatus.ongoing,
                ),
                TripActivityList(tripId: tripId, filter: ActivityStatus.done),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
