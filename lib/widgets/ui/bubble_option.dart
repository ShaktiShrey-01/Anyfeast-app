import 'package:flutter/material.dart';

class BubbleOption extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const BubbleOption({super.key, required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFE11D48) : Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: active ? const Color(0xFFE11D48) : Colors.grey.shade300),
          boxShadow: active ? [BoxShadow(color: const Color(0xFFE11D48).withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 2))] : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: active ? Colors.white : Colors.grey[700],
          ),
        ),
      ),
    );
  }
}