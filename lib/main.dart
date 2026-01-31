import 'package:flutter/material.dart';
import 'models/onboarding_data.dart';
import 'widgets/ui/progress_bar.dart';
import 'widgets/ui/context_pill.dart';
import 'widgets/ui/success_popup.dart'; // Import the new popup
import 'widgets/onboarding/step1_bio.dart';
import 'widgets/onboarding/step2_stats.dart';
import 'widgets/onboarding/step3_activity.dart';
import 'widgets/onboarding/step4_food.dart';
import 'widgets/onboarding/step5_logistics.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnyFeast Onboarding',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: const Color(0xFFF9FAFB), // gray-50
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _step = 1;
  final int _totalSteps = 5;
  late OnboardingData _data;

  @override
  void initState() {
    super.initState();
    _data = OnboardingData.initial();
  }

  void _update(String field, dynamic val) {
    setState(() {
      if (field == 'country') _data.country = val;
      if (field == 'gender') _data.gender = val;
      if (field == 'goal') _data.goal = val;
      if (field == 'pace') _data.pace = val;
      if (field == 'activityLevel') _data.activityLevel = val;
      if (field == 'diet') _data.diet = val;
      if (field == 'kitchen') _data.kitchen = val;
      if (field == 'budget') _data.budget = val;
      if (field == 'chefPersona') _data.chefPersona = val;
    });
  }

  void _updateNested(String parent, String field, dynamic val) {
    setState(() {
      if (parent == 'dob') _data.dob[field] = val;
      if (parent == 'measurements') _data.measurements[field] = val;
    });
  }

  void _toggleArray(String field, String item) {
    setState(() {
      List<String> list = field == 'activities' ? _data.activities : _data.healthGoals;
      if (list.contains(item)) {
        list.remove(item);
      } else {
        list.add(item);
      }
    });
  }

  void _handleNext() {
    if (_step == _totalSteps) {
      // Updated: Show the success popup dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const SuccessPopup();
        },
      );
    } else {
      setState(() => _step++);
    }
  }

  void _handleBack() {
    if (_step > 1) setState(() => _step--);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: const Color(0xFFE11D48), borderRadius: BorderRadius.circular(8)),
                      child: const Text("AF", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 8),
                    const Text("AnyFeast", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ]),
                  Text("Step $_step/$_totalSteps", style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
            ),
            
            // Main Card
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))],
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Column(
                  children: [
                    // Progress Bar
                    ProgressBar(current: _step, total: _totalSteps),
                    
                    // Live Context Bar
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      // Removed bottom padding to keep it tighter
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_step > 1) ...[
                            ContextPill(icon: Icons.person, label: _data.gender, color: Colors.blue, bgColor: Colors.blue.shade50, borderColor: Colors.blue.shade100),
                            const SizedBox(width: 4), // Reduced spacing
                          ],
                          if (_step >= 2) ...[
                            ContextPill(icon: Icons.scale, label: "${_data.measurements['w']} ${_data.measurements['unit'] == 'Metric' ? 'kg' : 'lbs'}", color: Colors.purple, bgColor: Colors.purple.shade50, borderColor: Colors.purple.shade100),
                            const SizedBox(width: 4),
                            ContextPill(icon: Icons.local_fire_department, label: _data.goal, color: const Color(0xFFE11D48), bgColor: const Color(0xFFFFF1F2), borderColor: const Color(0xFFFECDD3)),
                            const SizedBox(width: 4),
                          ],
                          if (_step > 4) ...[
                            ContextPill(icon: Icons.restaurant, label: _data.diet, color: Colors.green, bgColor: Colors.green.shade50, borderColor: Colors.green.shade100),
                          ]
                        ],
                      ),
                    ),
                    
                    // Scrollable Step Content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(32),
                        child: _buildStep(),
                      ),
                    ),

                    // Footer Buttons
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey.shade100)),
                      ),
                      child: Row(
                        children: [
                          if (_step > 1)
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: GestureDetector(
                                onTap: _handleBack,
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(16)),
                                  child: const Icon(Icons.chevron_left, color: Colors.grey),
                                ),
                              ),
                            ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _handleNext,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE11D48), // Rose-600
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                elevation: 4,
                                shadowColor: const Color(0xFFE11D48).withOpacity(0.4),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(_step == _totalSteps ? "Complete Profile" : "Continue", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.chevron_right, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case 1: return Step1Bio(data: _data, onUpdate: _update, onUpdateNested: _updateNested);
      case 2: return Step2Stats(data: _data, onUpdate: _update, onUpdateNested: _updateNested);
      case 3: return Step3Activity(data: _data, onUpdate: _update, toggleArray: _toggleArray);
      case 4: return Step4Food(data: _data, onUpdate: _update, toggleArray: _toggleArray);
      case 5: return Step5Logistics(data: _data, onUpdate: _update);
      default: return Container();
    }
  }
}