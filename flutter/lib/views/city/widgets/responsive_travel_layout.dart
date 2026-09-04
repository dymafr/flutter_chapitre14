import 'package:flutter/material.dart';

class ResponsiveTravelLayout extends StatelessWidget {
  const ResponsiveTravelLayout({
    required this.summary,
    required this.activities,
    super.key,
  });

  final Widget summary;
  final Widget activities;

  @override
  Widget build(BuildContext context) {
    final double availableWidth = MediaQuery.widthOf(context);
    final bool isWide = availableWidth >= 700;

    return Flex(
      key: const ValueKey<String>('travel-layout'),
      direction: isWide ? Axis.horizontal : Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          key: const ValueKey<String>('travel-summary'),
          width: isWide ? availableWidth * 0.4 : null,
          child: summary,
        ),
        if (isWide)
          const VerticalDivider(width: 1)
        else
          const Divider(height: 1),
        Expanded(child: activities),
      ],
    );
  }
}
