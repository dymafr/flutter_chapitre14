import '../models/activity_model.dart';
import '../models/trip_model.dart';

List<Trip> trips = [
  Trip(
    activities: [
      Activity(
        image: 'assets/images/activities/louvre.jpeg',
        name: 'Louvre',
        id: 'a1',
        city: 'Paris',
        price: 12.00,
      ),
      Activity(
        image: 'assets/images/activities/chaumont.jpeg',
        name: 'Chaumont',
        id: 'a2',
        city: 'Paris',
        price: 0.00,
      ),
      Activity(
        image: 'assets/images/activities/dame.jpeg',
        name: 'Notre-Dame',
        id: 'a3',
        city: 'Paris',
        price: 0.00,
      ),
    ],
    city: 'Paris',
    date: DateTime.now().add(const Duration(days: 1)),
  ),
  Trip(
      activities: [],
      city: 'Lyon',
      date: DateTime.now().add(const Duration(days: 2))),
  Trip(
      activities: [],
      city: 'Nice',
      date: DateTime.now().subtract(const Duration(days: 1))),
];