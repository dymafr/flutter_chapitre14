import 'package:flutter/material.dart';
import '../../../models/activity_model.dart';
import 'trip_activity_list.dart';

class TripActivities extends StatelessWidget {
  final String tripId;

  const TripActivities({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            child: TabBar(
              indicatorColor: Colors.blue[100],
              tabs: const <Widget>[
                Tab(
                  text: 'En cours',
                ),
                Tab(
                  text: 'Terminées',
                )
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
                TripActivityList(
                  tripId: tripId,
                  filter: ActivityStatus.done,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}