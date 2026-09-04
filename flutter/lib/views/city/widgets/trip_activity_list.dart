import 'package:flutter/material.dart';

import '../../../models/activity_model.dart';

class TripActivityList extends StatelessWidget {
  const TripActivityList({
    super.key,
    required this.activities,
    required this.onDelete,
  });

  final List<Activity> activities;
  final ValueChanged<Activity> onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (BuildContext context, int index) {
        final Activity activity = activities[index];

        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(activity.image),
            ),
            title: Text(activity.name),
            trailing: IconButton(
              tooltip: 'Retirer ${activity.name} du voyage',
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
              onPressed: () {
                onDelete(activity);
                final ColorScheme colors = Theme.of(context).colorScheme;
                final ScaffoldMessengerState messenger = ScaffoldMessenger.of(
                  context,
                );
                messenger
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        'Activité supprimée : ${activity.name}',
                        style: TextStyle(color: colors.onErrorContainer),
                      ),
                      backgroundColor: colors.errorContainer,
                      duration: const Duration(seconds: 1),
                    ),
                  );
              },
            ),
          ),
        );
      },
    );
  }
}
