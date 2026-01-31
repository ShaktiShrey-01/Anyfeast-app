class OnboardingData {
  String country;
  String gender;
  Map<String, String> dob;
  Map<String, dynamic> measurements;
  String goal;
  double targetWeight;
  String pace;
  String activityLevel;
  List<String> activities;
  String diet;
  List<String> healthGoals;
  String kitchen;
  double budget;
  String chefPersona;

  OnboardingData({
    this.country = 'IN',
    this.gender = 'female',
    required this.dob,
    required this.measurements,
    this.goal = 'lose',
    this.targetWeight = 65.0,
    this.pace = 'moderate',
    this.activityLevel = 'light',
    required this.activities,
    this.diet = 'non-veg',
    required this.healthGoals,
    this.kitchen = 'full',
    this.budget = 1500.0,
    this.chefPersona = 'noodles',
  });

  // Factory for initial state
  factory OnboardingData.initial() {
    return OnboardingData(
      dob: {'day': '1', 'month': 'Jan', 'year': '2000'},
      measurements: {'h': '170', 'w': '80', 'unit': 'Metric'},
      activities: [],
      healthGoals: [],
    );
  }
}