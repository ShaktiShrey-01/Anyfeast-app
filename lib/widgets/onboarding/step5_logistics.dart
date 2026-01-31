import 'package:flutter/material.dart';
import '../../models/onboarding_data.dart';
import '../ui/persona_card.dart';

class Step5Logistics extends StatelessWidget {
  final OnboardingData data;
  final Function(String, dynamic) onUpdate;

  const Step5Logistics({super.key, required this.data, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    String currency = data.country == 'IN' ? '₹' : '£';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Kitchen & Skill", textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        const SizedBox(height: 24),
        LayoutBuilder(builder: (context, constraints) {
          // Use a column for mobile simplicity in this snippet, 
          // or a GridView if you want exactly 2 columns like React
          return Column(
            children: [
              Row(children: [
                Expanded(child: _buildPCard('Me No Cooking', 'I can boil water', 'Toast, Instant noodles', Icons.close, 'nocook')),
                const SizedBox(width: 12),
                Expanded(child: _buildPCard('Me Makes Noodles', 'I follow recipes', 'Pasta, Stir-fries', Icons.soup_kitchen, 'noodles')),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: _buildPCard('Me Cooks Edible', 'I experiment', 'Multi-course meals', Icons.kitchen, 'edible')),
                const SizedBox(width: 12),
                Expanded(child: _buildPCard('Me Gordon Ramsay', 'LAMB SAUCE?!', 'Michelin techniques', Icons.star, 'ramsay')),
              ]),
            ],
          );
        }),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))]),
          child: Column(
            children: [
              Text("$currency${data.budget.toInt()} /week", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.black87)),
              Slider(
                value: data.budget,
                min: 500,
                max: 5000,
                divisions: 45,
                activeColor: Colors.green,
                onChanged: (v) => onUpdate('budget', v),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPCard(String t, String d, String s, IconData i, String id) {
    return PersonaCard(
      title: t,
      desc: d,
      sub: s,
      icon: i,
      selected: data.chefPersona == id,
      onTap: () => onUpdate('chefPersona', id),
    );
  }
}