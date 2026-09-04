import 'package:flutter/material.dart';

import '../../../models/activity_model.dart';
import 'activity_card.dart';

class ActivityList extends StatelessWidget {
  const ActivityList({
    super.key,
    required this.activities,
    required this.selectedActivities,
    required this.onToggle,
  });

  final List<Activity> activities;
  final List<Activity> selectedActivities;
  final ValueChanged<Activity> onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: GridView.extent(
        maxCrossAxisExtent: 150,
        mainAxisSpacing: 2,
        crossAxisSpacing: 5,
        children: activities.map((Activity activity) {
          return ActivityCard(
            activity: activity,
            isSelected: selectedActivities.contains(activity),
            onToggle: () => onToggle(activity),
          );
        }).toList(),
      ),
    );
  }
}
