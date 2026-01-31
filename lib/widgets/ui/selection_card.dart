import 'package:flutter/material.dart';

class SelectionCard extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final String title;
  final String? subtitle;
  final IconData icon;

  const SelectionCard({
    super.key,
    required this.selected,
    required this.onTap,
    required this.title,
    this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFFF1F2) : Colors.white, // rose-50
          border: Border.all(
            color: selected ? const Color(0xFFE11D48) : Colors.grey.shade200,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: selected
              ? [BoxShadow(color: Colors.red.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))]
              : [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            if (selected)
              const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Color(0xFFE11D48),
                  child: Icon(Icons.check, size: 10, color: Colors.white),
                ),
              ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFFFFE4E6) : Colors.grey[50],
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 28, color: selected ? const Color(0xFFE11D48) : Colors.grey[400]),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: selected ? const Color(0xFF881337) : Colors.grey[800],
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }
}