import 'package:flutter/material.dart';

import 'widgets/activity_form.dart';
import '../../widgets/dyma_drawer.dart';
import '../home/home_view.dart';
import '../trips/trips_view.dart';

class ActivityFormView extends StatelessWidget {
  static const String routeName = '/activity-form';

  const ActivityFormView({super.key});

  @override
  Widget build(BuildContext context) {
    String cityName = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: const Text('ajouter une activité')),
      drawer: DymaDrawer(
        onHomeSelected: () {
          Navigator.popUntil(context, ModalRoute.withName(HomeView.routeName));
        },
        onTripsSelected: () {
          Navigator.pushNamed<void>(context, TripsView.routeName);
        },
      ),
      body: ActivityForm(cityName: cityName),
    );
  }
}
