import 'package:flutter/material.dart';

class DymaLoader extends StatelessWidget {
  const DymaLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}