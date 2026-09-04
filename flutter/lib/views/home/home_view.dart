import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/city_provider.dart';
import '../../models/city_model.dart';
import '../../widgets/dyma_drawer.dart';
import '../trips/trips_view.dart';
import '../../widgets/dyma_loader.dart';
import 'widgets/city_card.dart';

class HomeView extends StatefulWidget {
  static const String routeName = '/';

  const HomeView({super.key});

  @override
  State<HomeView> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeView> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CityProvider cityProvider = Provider.of<CityProvider>(context);
    List<City> filteredCities = cityProvider.getFilteredCities(
      searchController.text,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('dymatrip')),
      drawer: DymaDrawer(
        onHomeSelected: () {},
        onTripsSelected: () {
          Navigator.pushNamed<void>(context, TripsView.routeName);
        },
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Rechercher une ville',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: searchController.clear,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: RefreshIndicator(
                displacement: 100.0,
                onRefresh: Provider.of<CityProvider>(
                  context,
                  listen: false,
                ).fetchData,
                child: cityProvider.isLoading && cityProvider.cities.isEmpty
                    ? const DymaLoader()
                    : filteredCities.isNotEmpty
                    ? ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: filteredCities.length,
                        itemBuilder: (_, i) =>
                            CityCard(city: filteredCities[i]),
                      )
                    : const Text('Aucun résultat'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
