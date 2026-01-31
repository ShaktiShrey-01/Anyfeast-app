import 'package:flutter/material.dart';

class ContextPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;
  final Color borderColor;

  const ContextPill({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Reduced padding and sizes to prevent overflow
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color), // Reduced size to 12
          const SizedBox(width: 4), // Reduced spacing
          Flexible( // Added Flexible to handle long text gracefully if absolutely necessary
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 11, // Reduced font size to 11
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}