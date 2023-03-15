import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/city_model.dart';
import '../../models/activity_model.dart';
import '../../models/trip_model.dart';
import '../../providers/city_provider.dart';
import '../../providers/trip_provider.dart';
import '../../widgets/dyma_drawer.dart';
import '../activity_form/activity_form_view.dart';
import '../home/home_view.dart';
import 'widgets/trip_activity_list.dart';
import 'widgets/activity_list.dart';
import 'widgets/trip_overview.dart';


class CityView extends StatefulWidget {
  static const String routeName = '/city';

  const CityView({super.key});

  @override
  State<CityView> createState() => _CityState();
}

class _CityState extends State<CityView> {
  late Trip mytrip;
  late int index;

  @override
  void initState() {
    super.initState();
    index = 0;
    mytrip = Trip(
      activities: [],
      date: null,
      city: '',
    );
  }

  double get amount {
    return mytrip.activities.fold(0.0, (prev, element) {
      return prev + element.price;
    });
  }

  void setDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    ).then((newDate) {
      if (newDate != null) {
        setState(() {
          mytrip.date = newDate;
        });
      }
    });
  }

  void switchIndex(newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  void toggleActivity(Activity activity) {
    setState(() {
      mytrip.activities.contains(activity)
          ? mytrip.activities.remove(activity)
          : mytrip.activities.add(activity);
    });
  }

  void deleteTripActivity(Activity activity) {
    setState(() {
      mytrip.activities.remove(activity);
    });
  }

  void saveTrip(String cityName) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Voulez vous sauvegarder ?'),
          contentPadding: const EdgeInsets.all(20),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  child: const Text('annuler'),
                  onPressed: () {
                    Navigator.pop(context, 'cancel');
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.pop(context, 'save');
                  },
                  child: const Text(
                    'sauvegarder',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
    if (mytrip.date == null) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Attention !'),
            content: const Text('Vous n\'avez pas entré de date'),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        );
      }

    } else if (result == 'save') {
      if (mounted) {
        mytrip.city = cityName;
        Provider.of<TripProvider>(context, listen: false).addTrip(mytrip);
        Navigator.pushNamed(context, HomeView.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String cityName = ModalRoute.of(context)!.settings.arguments as String;
    City city = Provider.of<CityProvider>(context).getCityByName(cityName);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Organisation voyage'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(
              context,
              ActivityFormView.routeName,
              arguments: cityName,
            ),
          )
        ],
      ),
      drawer: const DymaDrawer(),
      body: Column(
        children: <Widget>[
          TripOverview(
              cityName: city.name,
              mytrip: mytrip,
              setDate: setDate,
              amount: amount),
          Expanded(
            child: index == 0
                ? ActivityList(
              activities: city.activities,
              selectedActivities: mytrip.activities,
              toggleActivity: toggleActivity,
            )
                : TripActivityList(
              activities: mytrip.activities,
              deleteTripActivity: deleteTripActivity,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.forward),
        onPressed: () => saveTrip(city.name),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Découverte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stars),
            label: 'Mes activités',
          )
        ],
        onTap: switchIndex,
      ),
    );
  }
}