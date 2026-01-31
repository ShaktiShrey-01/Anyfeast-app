import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int current;
  final int total;

  const ProgressBar({super.key, required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    double percentage = (current / total).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
      child: Container(
        height: 8,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(100),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: percentage,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE11D48), // Rose-600
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ),
    );
  }
}