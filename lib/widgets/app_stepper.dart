import 'package:flutter/material.dart';
import 'package:charging_station/models/model.dart';

class AppStepper extends StatelessWidget {
  final int active;
  final List<StepModel> list;

  const AppStepper({super.key, this.active = 0, required this.list});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children:
              list.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                Color circleColor = Theme.of(context).dividerColor;
                Color? iconColor;
                Color? lineLeftColor;
                Color? lineRightColor;
                if (index != 0) {
                  lineLeftColor = Theme.of(context).dividerColor;
                }
                if (index != list.length - 1) {
                  lineRightColor = Theme.of(context).dividerColor;
                }
                if (index <= active) {
                  circleColor = Theme.of(context).colorScheme.primary;
                  iconColor = Colors.white;
                }
                if (index < active) {
                  lineRightColor = Theme.of(context).colorScheme.primary;
                }
                if (index <= active && index > 0) {
                  lineLeftColor = Theme.of(context).colorScheme.primary;
                }
                return Expanded(
                  child: Column(
                    children: [
                      Text(
                        item.title,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Container(height: 2, color: lineLeftColor),
                          ),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: circleColor,
                            ),
                            child: Icon(item.icon, color: iconColor, size: 14),
                          ),
                          Expanded(
                            child: Container(height: 2, color: lineRightColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
