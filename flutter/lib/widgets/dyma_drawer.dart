import 'package:flutter/material.dart';

class DymaDrawer extends StatelessWidget {
  const DymaDrawer({
    required this.onHomeSelected,
    required this.onTripsSelected,
    super.key,
  });

  final VoidCallback onHomeSelected;
  final VoidCallback onTripsSelected;

  void _select(BuildContext context, VoidCallback action) {
    Navigator.pop(context);
    action();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: colors.primaryContainer),
            child: Text(
              'Dyma Trip',
              style: Theme.of(context).textTheme.headlineMedium
                  ?.copyWith(color: colors.onPrimaryContainer),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Accueil'),
            onTap: () => _select(context, onHomeSelected),
          ),
          ListTile(
            leading: const Icon(Icons.flight),
            title: const Text('Mes voyages'),
            onTap: () => _select(context, onTripsSelected),
          ),
        ],
      ),
    );
  }
}
