import 'package:flutter/material.dart';

//Source for all calculation: https://www.omnicalculator.com/health/dri#what-is-dri
//Exclude pregnancy and smoking factor

class DRIResult {
  final String nutrient;
  final double value;
  String unit = "";

  DRIResult({required this.nutrient, required this.value, required this.unit});
}

enum ActivityLevel {
  littleNoExercise,
  oneTwoTimesWeek,
  twoThreeTimesWeek,
  threeFiveTimesWeek,
  sixSevenTimesWeek,
  professionalAthlete,
}

enum Gender {
  male,
  female,
}

class NutrientCalculator {
  static void calculateDRI({
    required String age,
    required String weight,
    required String height,
    required ActivityLevel selectedActivityLevel,
    required Gender selectedGender,
    required List<DRIResult> driResults,
  }) {
    driResults.clear();

    // Get user inputs
    int parsedAge = int.parse(age);
    double parsedWeight = double.parse(weight);
    double parsedHeight = double.parse(height);

    // Calculate DRI for vitamins
    // Bullshittery , replace later. Also in gram, not mgr btw
    double vitaminA = parsedAge * 100;
    double vitaminD = parsedAge * 10;
    double vitaminE = parsedWeight * 5;
    double vitaminK = parsedWeight * 2;
    double vitaminC = parsedWeight * 10;

    // Calculate DRI for calories
    // Random number replace later
    double calories = NutrientCalculator.calculateCalories(
      parsedWeight,
      parsedHeight,
      selectedActivityLevel,
      selectedGender,
    );

    // Calculate DRI for macronutrients
    // Random number replace later. Based on calorie
    double protein = parsedWeight * 1.5;
    double carbs = parsedWeight * 2.5;
    double fat = parsedWeight * 0.8;

    // Add DRI results to the list
    driResults
        .add(DRIResult(nutrient: 'Vitamin A', value: vitaminA, unit: 'mg'));
    driResults
        .add(DRIResult(nutrient: 'Vitamin D', value: vitaminD, unit: 'mg'));
    driResults
        .add(DRIResult(nutrient: 'Vitamin E', value: vitaminE, unit: 'mg'));
    driResults
        .add(DRIResult(nutrient: 'Vitamin K', value: vitaminK, unit: 'mg'));
    driResults
        .add(DRIResult(nutrient: 'Vitamin C', value: vitaminC, unit: 'mg'));
    driResults.add(DRIResult(nutrient: 'Calories', value: calories, unit: ''));
    driResults.add(DRIResult(nutrient: 'Protein', value: protein, unit: 'g'));
    driResults
        .add(DRIResult(nutrient: 'Carbohydrates', value: carbs, unit: 'g'));
    driResults.add(DRIResult(nutrient: 'Fat', value: fat, unit: 'g'));
  }

  static double calculateCalories(
    double weight,
    double height,
    ActivityLevel activityLevel,
    Gender gender,
  ) {
    double baseCalories = weight * 30;

    double genderFactor = gender == Gender.male ? 1.0 : 0.9;

    switch (activityLevel) {
      case ActivityLevel.littleNoExercise:
        return baseCalories * 1.2 * genderFactor;
      case ActivityLevel.oneTwoTimesWeek:
        return baseCalories * 1.375 * genderFactor;
      case ActivityLevel.twoThreeTimesWeek:
        return baseCalories * 1.55 * genderFactor;
      case ActivityLevel.threeFiveTimesWeek:
        return baseCalories * 1.725 * genderFactor;
      case ActivityLevel.sixSevenTimesWeek:
        return baseCalories * 1.9 * genderFactor;
      case ActivityLevel.professionalAthlete:
        return baseCalories * 2.3 * genderFactor;
      default:
        return baseCalories;
    }
  }
}
