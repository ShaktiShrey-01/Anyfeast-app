import 'package:flutter/material.dart';
import '../../models/onboarding_data.dart';
import '../ui/selection_card.dart';

class Step1Bio extends StatelessWidget {
  final OnboardingData data;
  final Function(String, dynamic) onUpdate;
  final Function(String, String, dynamic) onUpdateNested;

  const Step1Bio({
    Key? key, 
    required this.data, 
    required this.onUpdate, 
    required this.onUpdateNested
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Generate Dropdown Data
    final days = List.generate(31, (index) => (index + 1).toString());
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final years = List.generate(100, (index) => (DateTime.now().year - 10 - index).toString());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Let's start your journey!", 
          textAlign: TextAlign.center, 
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)
        ),
        const SizedBox(height: 8),
        const Text(
          "First, where are you located?", 
          textAlign: TextAlign.center, 
          style: TextStyle(color: Colors.grey)
        ),
        const SizedBox(height: 24),
        
        // Country Selection
        Row(
          children: [
            Expanded(
              child: SelectionCard(
                selected: data.country == 'IN', 
                onTap: () => onUpdate('country', 'IN'), 
                title: "India", 
                subtitle: "INR", 
                icon: Icons.public
              )
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SelectionCard(
                selected: data.country == 'UK', 
                onTap: () => onUpdate('country', 'UK'), 
                title: "UK", 
                subtitle: "GBP", 
                icon: Icons.public
              )
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Bio Details Container
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[50], 
            borderRadius: BorderRadius.circular(24), 
            border: Border.all(color: Colors.grey.shade200)
          ),
          child: Column(
            children: [
              // Gender Toggle
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(12), 
                  border: Border.all(color: Colors.grey.shade200)
                ),
                child: Row(
                  children: ['Male', 'Female'].map((g) {
                    bool isSelected = data.gender == g.toLowerCase();
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => onUpdate('gender', g.toLowerCase()),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFE11D48) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            g, 
                            textAlign: TextAlign.center, 
                            style: TextStyle(
                              fontWeight: FontWeight.bold, 
                              color: isSelected ? Colors.white : Colors.grey
                            )
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // --- FIXED: Real Dropdowns ---
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildDropdown(
                      "Day", 
                      data.dob['day']!, 
                      days, 
                      (v) => onUpdateNested('dob', 'day', v)
                    )
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: _buildDropdown(
                      "Month", 
                      data.dob['month']!, 
                      months, 
                      (v) => onUpdateNested('dob', 'month', v)
                    )
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: _buildDropdown(
                      "Year", 
                      data.dob['year']!, 
                      years, 
                      (v) => onUpdateNested('dob', 'year', v)
                    )
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper widget for specific Dropdown styling
  Widget _buildDropdown(String label, String value, List<String> items, Function(String?) onChanged) {
    // Ensure the current value exists in the list, otherwise default to first item to prevent crash
    String safeValue = items.contains(value) ? value : items.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(), 
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12)
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: safeValue,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 16),
              style: const TextStyle(
                color: Colors.black87, 
                fontWeight: FontWeight.bold, 
                fontSize: 14,
                fontFamily: 'Roboto' // Ensure font matches app
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        )
      ],
    );
  }
}