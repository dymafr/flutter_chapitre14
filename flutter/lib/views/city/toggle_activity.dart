import '../../models/activity_model.dart';

void toggleActivitySelection(
  List<Activity> selectedActivities,
  Activity activity,
) {
  if (selectedActivities.contains(activity)) {
    selectedActivities.remove(activity);
  } else {
    selectedActivities.add(activity);
  }
}
