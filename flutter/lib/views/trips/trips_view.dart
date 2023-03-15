import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/trip_provider.dart';
import '../../widgets/dyma_loader.dart';
import 'widgets/trip_list.dart';
import '../../widgets/dyma_drawer.dart';

class TripsView extends StatelessWidget {
  static const String routeName = '/trips';

  const TripsView({super.key});

  @override
  Widget build(BuildContext context) {
    TripProvider tripProvider = Provider.of<TripProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mes voyages'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'A venir',
              ),
              Tab(
                text: 'Passés',
              ),
            ],
          ),
        ),
        drawer: const DymaDrawer(),
        body: tripProvider.isLoading == false
            ? tripProvider.trips.isNotEmpty
            ? TabBarView(
          children: <Widget>[
            TripList(
              trips: tripProvider.trips
                  .where((trip) => DateTime.now().isBefore(trip.date!))
                  .toList(),
            ),
            TripList(
              trips: tripProvider.trips
                  .where((trip) => DateTime.now().isAfter(trip.date!))
                  .toList(),
            ),
          ],
        )
            : Container(
          alignment: Alignment.center,
          child: const Text('Aucun voyage pour le moment'),
        )
            : const DymaLoader(),
      ),
    );
  }
}