import 'package:flutter/material.dart';

class PersonaCard extends StatelessWidget {
  final String title;
  final String desc;
  final String sub;
  final bool selected;
  final VoidCallback onTap;
  final IconData icon;

  const PersonaCard({
    super.key,
    required this.title,
    required this.desc,
    required this.sub,
    required this.selected,
    required this.onTap,
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
          color: selected ? const Color(0xFFFFF1F2) : Colors.white,
          border: Border.all(
            color: selected ? const Color(0xFFE11D48) : Colors.grey.shade200,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xFFFECDD3) : Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 20, color: selected ? const Color(0xFFBE123C) : Colors.grey),
                ),
                if (selected)
                  const CircleAvatar(
                    radius: 8,
                    backgroundColor: Color(0xFFE11D48),
                    child: Icon(Icons.check, size: 10, color: Colors.white),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text(desc, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Color(0xFFE11D48))),
            const SizedBox(height: 4),
            Text(sub, style: TextStyle(fontSize: 12, color: Colors.grey[500], height: 1.4)),
          ],
        ),
      ),
    );
  }
}