import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/activity_model.dart';
import '../models/city_model.dart';

class CityProvider extends ChangeNotifier {
  final String host = 'localhost';
  List<City> _cities = [];
  bool isLoading = false;

  UnmodifiableListView<City> get cities => UnmodifiableListView(_cities);

  City getCityByName(String cityName) =>
      cities.firstWhere((city) => city.name == cityName);

  UnmodifiableListView<City> getFilteredCities(String filter) =>
      UnmodifiableListView(
        _cities
            .where(
              (city) =>
                  city.name.toLowerCase().startsWith(filter.toLowerCase()),
            )
            .toList(),
      );

  Future<void> fetchData() async {
    try {
      isLoading = true;
      notifyListeners();
      http.Response response = await http.get(Uri.http(host, '/api/cities'));
      if (response.statusCode == 200) {
        _cities = (json.decode(response.body) as List)
            .map((cityJson) => City.fromJson(cityJson))
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

  Future<void> addActivityToCity(Activity newActivity) async {
    try {
      String cityId = getCityByName(newActivity.city).id!;
      http.Response response = await http.post(
        Uri.http(host, '/api/city/$cityId/activity'),
        headers: {'Content-type': 'application/json'},
        body: json.encode(newActivity.toJson()),
      );
      if (response.statusCode == 200) {
        int index = _cities.indexWhere((city) => city.id == cityId);
        _cities[index] = City.fromJson(json.decode(response.body));
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> verifyIfActivityNameIsUnique(
    String cityName,
    String activityName,
  ) async {
    try {
      final City city = getCityByName(cityName);
      final http.Response response = await http.get(
        Uri.http(host, '/api/city/${city.id}/activities/verify/$activityName'),
      );
      if (response.statusCode != 200) {
        return json.decode(response.body) as String;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
