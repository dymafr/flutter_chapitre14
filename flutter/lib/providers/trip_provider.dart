import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/activity_model.dart';
import '../models/trip_model.dart';

class TripProvider extends ChangeNotifier {
  final String host = 'localhost';
  List<Trip> _trips = [];
  bool isLoading = false;

  UnmodifiableListView<Trip> get trips => UnmodifiableListView(_trips);

  Future<void> fetchData() async {
    try {
      isLoading = true;
      notifyListeners();
      http.Response response = await http.get(Uri.http(host, '/api/trips'));
      if (response.statusCode == 200) {
        _trips = (json.decode(response.body) as List)
            .map((tripJson) => Trip.fromJson(tripJson))
            .toList();
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> addTrip(Trip trip) async {
    try {
      http.Response response = await http.post(
        Uri.http(host, '/api/trip'),
        body: json.encode(trip.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        _trips.add(Trip.fromJson(json.decode(response.body)));
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTrip(Trip trip, String activityId) async {
    final Activity activity = trip.activities.firstWhere(
      (activity) => activity.id == activityId,
      orElse: () => throw StateError(
        'Aucune activité $activityId dans le voyage ${trip.city}.',
      ),
    );
    final ActivityStatus previousStatus = activity.status;
    activity.status = ActivityStatus.done;
    try {
      http.Response response = await http.put(
        Uri.http(host, '/api/trip'),
        body: json.encode(trip.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) {
        throw Exception(
          'Le serveur a refusé la mise à jour (statut ${response.statusCode}).',
        );
      }
    } catch (_) {
      activity.status = previousStatus;
      rethrow;
    }
    notifyListeners();
  }

  Trip getById(String id) {
    return trips.firstWhere((trip) => trip.id == id);
  }
}
