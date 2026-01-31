import 'package:flutter/material.dart';
import '../../models/onboarding_data.dart';

class Step2Stats extends StatelessWidget {
  final OnboardingData data;
  final Function(String, dynamic) onUpdate;
  final Function(String, String, dynamic) onUpdateNested;

  const Step2Stats({super.key, required this.data, required this.onUpdate, required this.onUpdateNested});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Body Metrics", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        const SizedBox(height: 16),
        // Metric Toggle
        Container(
          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: ['Metric', 'Imperial'].map((u) {
              bool selected = data.measurements['unit'] == u;
              return GestureDetector(
                onTap: () => onUpdateNested('measurements', 'unit', u),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(color: selected ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(8), boxShadow: selected ? [const BoxShadow(color: Colors.black12, blurRadius: 2)] : []),
                  child: Text(u, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: selected ? const Color(0xFFE11D48) : Colors.grey)),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade200)),
          child: Row(
            children: [
              Expanded(child: _buildInput("HEIGHT", data.measurements['h']!, (v) => onUpdateNested('measurements', 'h', v), data.measurements['unit'] == 'Metric' ? 'cm' : 'ft')),
              const SizedBox(width: 24),
              Expanded(child: _buildInput("WEIGHT", data.measurements['w']!, (v) => onUpdateNested('measurements', 'w', v), data.measurements['unit'] == 'Metric' ? 'kg' : 'lbs')),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            {'id': 'lose', 'l': 'Lose'},
            {'id': 'maintain', 'l': 'Maintain'},
            {'id': 'gain', 'l': 'Gain'}
          ].map((g) {
            bool active = data.goal == g['id'];
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: () => onUpdate('goal', g['id']),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: active ? const Color(0xFFFFF1F2) : Colors.white,
                      border: Border.all(color: active ? const Color(0xFFE11D48) : Colors.grey.shade200, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(g['l']!, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: active ? const Color(0xFFBE123C) : Colors.grey[600])),
                  ),
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  Widget _buildInput(String label, String val, Function(String) onChanged, String unit) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
      Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
        Expanded(child: TextFormField(initialValue: val, onChanged: onChanged, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900), decoration: const InputDecoration(border: InputBorder.none, isDense: true))),
        Text(unit, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
      ])
    ]);
  }
}