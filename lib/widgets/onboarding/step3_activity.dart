import 'package:flutter/material.dart';
import '../../models/onboarding_data.dart';
import '../ui/selection_card.dart';
import '../ui/bubble_option.dart';

class Step3Activity extends StatelessWidget {
  final OnboardingData data;
  final Function(String, dynamic) onUpdate;
  final Function(String, String) toggleArray;

  const Step3Activity({Key? key, required this.data, required this.onUpdate, required this.toggleArray}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define cards data
    final cards = [
      {'id': 'sedentary', 't': 'Sedentary', 's': 'Desk job'},
      {'id': 'light', 't': 'Light', 's': '1-3 days/wk'},
      {'id': 'moderate', 't': 'Moderate', 's': '3-5 days/wk'},
      {'id': 'intense', 't': 'Intense', 's': '6-7 days/wk'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Activity Level", textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        const SizedBox(height: 24),
        // Switched from fixed GridView to flexible Rows/Expanded to prevent overflow
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildCard(cards[0])),
                const SizedBox(width: 12),
                Expanded(child: _buildCard(cards[1])),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildCard(cards[2])),
                const SizedBox(width: 12),
                Expanded(child: _buildCard(cards[3])),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text("Main Activities", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['Running', 'Swimming', 'Cycling', 'Yoga', 'Weights'].map((act) {
            return BubbleOption(
              label: act,
              active: data.activities.contains(act),
              onTap: () => toggleArray('activities', act),
            );
          }).toList(),
        )
      ],
    );
  }

  Widget _buildCard(Map<String, String> item) {
    return SelectionCard(
      selected: data.activityLevel == item['id'],
      onTap: () => onUpdate('activityLevel', item['id']),
      title: item['t']!,
      subtitle: item['s'],
      icon: Icons.directions_run,
    );
  }
}