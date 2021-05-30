import 'package:flutter/material.dart';
import './widgets/activity_form.dart';
import '../../widgets/dyma_drawer.dart';

class ActivityFormView extends StatelessWidget {
  static const String routeName = '/activity-form';

  @override
  Widget build(BuildContext context) {
    String cityName = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('ajouter une activité'),
      ),
      drawer: DymaDrawer(),
      body: ActivityForm(cityName: cityName),
    );
  }
}
