import 'package:flutter/material.dart';

void main() => runApp(const ObserverApp());

class ObserverApp extends StatelessWidget {
  const ObserverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ObserverScreen());
  }
}

class ObserverScreen extends StatefulWidget {
  const ObserverScreen({this.onObserved, super.key});

  final ValueChanged<AppLifecycleState>? onObserved;

  @override
  State<ObserverScreen> createState() => _ObserverScreenState();
}

class _ObserverScreenState extends State<ObserverScreen>
    with WidgetsBindingObserver {
  AppLifecycleState? _state;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _state = WidgetsBinding.instance.lifecycleState;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    widget.onObserved?.call(state);
    if (!mounted) return;
    setState(() => _state = state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          _state == null
              ? 'Aucun état reçu'
              : 'AppLifecycleState.${_state!.name}',
          key: const ValueKey<String>('observer-state'),
        ),
      ),
    );
  }
}
