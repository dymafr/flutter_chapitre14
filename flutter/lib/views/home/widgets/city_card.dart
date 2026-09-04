import 'package:flutter/material.dart';

import '../../../models/city_model.dart';
import '../../city/city_view.dart';

class CityCard extends StatelessWidget {
  const CityCard({required this.city, super.key});

  final City city;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SizedBox(
        height: 150,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Ink.image(
              image: NetworkImage(city.image),
              fit: BoxFit.cover,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed<void>(
                    context,
                    CityView.routeName,
                    arguments: city.name,
                  );
                },
              ),
            ),
            Positioned(
              left: 10,
              top: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                color: Colors.black54,
                child: Text(
                  city.name,
                  style: const TextStyle(fontSize: 35, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
