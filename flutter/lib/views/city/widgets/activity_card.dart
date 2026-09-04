import 'package:flutter/material.dart';

import '../../../models/activity_model.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final bool isSelected;
  final VoidCallback? onToggle;

  const ActivityCard({
    super.key,
    required this.activity,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: onToggle != null,
      selected: isSelected,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        child: Ink(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(activity.image),
              fit: BoxFit.cover,
            ),
          ),
          child: InkWell(
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (isSelected)
                          const Icon(
                            Icons.check_circle,
                            size: 40,
                            color: Colors.white,
                          ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            activity.name,
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              shadows: <Shadow>[
                                Shadow(blurRadius: 4, color: Colors.black),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
