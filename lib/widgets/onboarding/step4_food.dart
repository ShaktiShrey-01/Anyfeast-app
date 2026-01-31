import 'package:flutter/material.dart';
import '../../models/onboarding_data.dart';
import '../ui/bubble_option.dart';

class Step4Food extends StatelessWidget {
  final OnboardingData data;
  final Function(String, dynamic) onUpdate;
  final Function(String, String) toggleArray;

  const Step4Food({super.key, required this.data, required this.onUpdate, required this.toggleArray});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Preferences", textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: ['Veg', 'Non-Veg', 'Vegan', 'Keto', 'Paleo', 'Jain'].map((d) {
             bool active = data.diet == d.toLowerCase();
             return GestureDetector(
               onTap: () => onUpdate('diet', d.toLowerCase()),
               child: Container(
                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                 decoration: BoxDecoration(
                   color: active ? Colors.green[50] : Colors.white,
                   border: Border.all(color: active ? Colors.green : Colors.grey.shade200, width: 2),
                   borderRadius: BorderRadius.circular(16),
                 ),
                 child: Text(d, style: TextStyle(fontWeight: FontWeight.bold, color: active ? Colors.green[800] : Colors.grey[700])),
               ),
             );
          }).toList(),
        ),
        const SizedBox(height: 32),
        const Text("Health Goals", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['Muscle Gain', 'Heart Health', 'Brain Health', 'Sleep', 'Skin', 'Energy'].map((h) {
            return BubbleOption(
              label: h,
              active: data.healthGoals.contains(h),
              onTap: () => toggleArray('healthGoals', h),
            );
          }).toList(),
        ),
      ],
    );
  }
}