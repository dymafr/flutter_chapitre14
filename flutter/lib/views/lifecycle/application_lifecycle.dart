import 'package:flutter/material.dart';

void main() => runApp(const LifecycleApp());

class LifecycleJournal extends ChangeNotifier {
  final List<AppLifecycleState> _states = <AppLifecycleState>[];

  List<AppLifecycleState> get states =>
      List<AppLifecycleState>.unmodifiable(_states);

  void record(AppLifecycleState state) {
    _states.add(state);
    notifyListeners();
  }

  void clear() {
    _states.clear();
    notifyListeners();
  }
}

class LifecycleApp extends StatelessWidget {
  const LifecycleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LifecycleScreen(journal: LifecycleJournal()));
  }
}

class LifecycleScreen extends StatefulWidget {
  const LifecycleScreen({
    required this.journal,
    this.onObserved,
    this.listenToBinding = true,
    super.key,
  });

  final LifecycleJournal journal;
  final ValueChanged<AppLifecycleState>? onObserved;
  final bool listenToBinding;

  @override
  State<LifecycleScreen> createState() => _LifecycleScreenState();
}

class _LifecycleScreenState extends State<LifecycleScreen> {
  AppLifecycleListener? _listener;

  @override
  void initState() {
    super.initState();
    if (widget.listenToBinding) {
      _listener = AppLifecycleListener(onStateChange: _handleStateChange);
    }
  }

  void _handleStateChange(AppLifecycleState state) {
    widget.onObserved?.call(state);
    if (!mounted) return;
    widget.journal.record(state);
  }

  @override
  void dispose() {
    _listener?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cycle de l'application")),
      body: AnimatedBuilder(
        animation: widget.journal,
        builder: (context, child) {
          if (widget.journal.states.isEmpty) {
            return const Center(child: Text('Aucun état reçu'));
          }
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (final (index, state) in widget.journal.states.indexed)
                  Text(
                    'AppLifecycleState.${state.name}',
                    key: ValueKey<String>('journal-$index-${state.name}'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
