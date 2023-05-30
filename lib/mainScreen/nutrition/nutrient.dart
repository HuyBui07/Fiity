//Source for all calculation: https://www.omnicalculator.com/health/dri#what-is-dri
//Exclude pregnancy and smoking factor
// Vitamin calculation : https://www.ncbi.nlm.nih.gov/books/NBK56068/table/summarytables.t2/?report=objectonly

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

class Ultis {
  static Gender genderFromString(String genderString) {
    if (genderString == "male")
      return Gender.male;
    else
      return Gender.female;
  }

  static ActivityLevel activityLevelFromString(String activityLevelString) {
    switch (activityLevelString) {
      case "littleNoExercise":
        return ActivityLevel.littleNoExercise;
      case "oneTwoTimesWeek":
        return ActivityLevel.oneTwoTimesWeek;
      case "twoThreeTimesWeek":
        return ActivityLevel.twoThreeTimesWeek;
      case "threeFiveTimesWeek":
        return ActivityLevel.threeFiveTimesWeek;
      case "sixSevenTimesWeek":
        return ActivityLevel.sixSevenTimesWeek;
      case "professionalAthlete":
        return ActivityLevel.professionalAthlete;
      default:
        return ActivityLevel.littleNoExercise;
    }
  }
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
    double vitaminA = calculateVitaminA(parsedAge, selectedGender);
    double vitaminD = calculateVitaminD(parsedAge, selectedGender);
    double vitaminE = calculateVitaminE(parsedAge);
    double vitaminK = calculateVitaminK(parsedAge, selectedGender);
    double vitaminC = calculateVitaminC(parsedAge, selectedGender);

    // Calculate DRI for calories
    double calories = calculateCalories(
      parsedWeight,
      parsedHeight,
      selectedActivityLevel,
      selectedGender,
    );

    // Calculate DRI for macronutrients
    double protein = calculateProtein(calories);
    double fat = calculateFat(calories);
    double carbs = calculateCarbohydrates(calories);

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
    driResults.add(DRIResult(nutrient: 'Fat', value: fat, unit: 'g'));
    driResults
        .add(DRIResult(nutrient: 'Carbohydrates', value: carbs, unit: 'g'));
  }

  static double calculateVitaminA(int age, Gender gender) {
    if (gender == Gender.male) {
      if (age >= 1 && age <= 3) return 300;
      if (age >= 4 && age <= 8) return 400;
      if (age >= 9 && age <= 13) return 600;
      if (age >= 14 && age <= 18) return 900;
      if (age >= 19) return 900;
    } else {
      if (age >= 1 && age <= 3) return 300;
      if (age >= 4 && age <= 8) return 400;
      if (age >= 9 && age <= 13) return 600;
      if (age >= 14 && age <= 18) return 700;
      if (age >= 19) return 700;
    }
    return 0;
  }

  static double calculateVitaminD(int age, Gender gender) {
    if (gender == Gender.male) {
      if (age >= 1 && age <= 3) return 15;
      if (age >= 4 && age <= 8) return 15;
      if (age >= 9 && age <= 13) return 15;
      if (age >= 14 && age <= 18) return 15;
      if (age >= 19 && age <= 70) return 15;
      if (age > 70) return 20;
    } else {
      if (age >= 1 && age <= 3) return 15;
      if (age >= 4 && age <= 8) return 15;
      if (age >= 9 && age <= 13) return 15;
      if (age >= 14 && age <= 18) return 15;
      if (age >= 19 && age <= 70) return 15;
      if (age > 70) return 20;
    }
    return 0;
  }

  static double calculateVitaminE(int age) {
    if (age >= 1 && age <= 3) return 6;
    if (age >= 4 && age <= 8) return 7;
    if (age >= 9 && age <= 13) return 11;
    if (age >= 14 && age <= 18) return 15;
    if (age >= 19) return 15;
    return 0;
  }

  static double calculateVitaminK(int age, Gender gender) {
    if (gender == Gender.male) {
      if (age >= 1 && age <= 3) return 30;
      if (age >= 4 && age <= 8) return 55;
      if (age >= 9 && age <= 13) return 60;
      if (age >= 14 && age <= 18) return 75;
      if (age >= 19) return 120;
    } else {
      if (age >= 1 && age <= 3) return 30;
      if (age >= 4 && age <= 8) return 55;
      if (age >= 9 && age <= 13) return 60;
      if (age >= 14 && age <= 18) return 75;
      if (age >= 19) return 90;
    }
    return 0;
  }

  static double calculateVitaminC(int age, Gender gender) {
    if (gender == Gender.male) {
      if (age >= 1 && age <= 3) return 15;
      if (age >= 4 && age <= 8) return 25;
      if (age >= 9 && age <= 13) return 45;
      if (age >= 14 && age <= 18) return 75;
      if (age >= 19) return 90;
    } else {
      if (age >= 1 && age <= 3) return 15;
      if (age >= 4 && age <= 8) return 25;
      if (age >= 9 && age <= 13) return 45;
      if (age >= 14 && age <= 18) return 65;
      if (age >= 19) return 75;
    }
    return 0;
  }

  static double calculateCalories(
    double weight,
    double height,
    ActivityLevel activityLevel,
    Gender gender,
  ) {
    double bmr;

    // Basal Metabolic Rate Formula (Mifflin-St Jeor)
    if (gender == Gender.male) {
      bmr = 10 * weight + 6.25 * height - 5 * 30 + 5;
    } else {
      bmr = 10 * weight + 6.25 * height - 5 * 30 - 161;
    }

    double activityFactor = 1.0;

    switch (activityLevel) {
      case ActivityLevel.littleNoExercise:
        activityFactor = 1.2;
        break;
      case ActivityLevel.oneTwoTimesWeek:
        activityFactor = 1.375;
        break;
      case ActivityLevel.twoThreeTimesWeek:
        activityFactor = 1.55;
        break;
      case ActivityLevel.threeFiveTimesWeek:
        activityFactor = 1.725;
        break;
      case ActivityLevel.sixSevenTimesWeek:
        activityFactor = 1.9;
        break;
      case ActivityLevel.professionalAthlete:
        activityFactor = 2.3;
        break;
    }

    return bmr * activityFactor;
  }

  static double calculateProtein(double calories) {
    return (calories * 0.15) / 4;
  }

  static double calculateFat(double calories) {
    return (calories * 0.3) / 9;
  }

  static double calculateCarbohydrates(double calories) {
    return (calories * 0.55) / 4;
  }
}
