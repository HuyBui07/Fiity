import 'package:fitty/mainScreen/nutrition/nutrient.dart';

class User {
  int? id;
  Gender _gender;
  String name = "User";
  int _age;
  int _weight; // In kilograms
  int _height; // In centimeters
  ActivityLevel _activityLevel;

  User({
    this.id,
    Gender gender = Gender.male,
    int age = 18,
    int weight = 45,
    int height = 170,
    ActivityLevel activityLevel = ActivityLevel.littleNoExercise,
  })  : _gender = gender,
        _age = age,
        _weight = weight,
        _height = height,
        _activityLevel = activityLevel;

  Gender get gender => _gender;
  set gender(Gender value) => _gender = value;

  int get age => _age;
  set age(int value) => _age = value;

  int get weight => _weight;
  set weight(int value) => _weight = value;

  int get height => _height;
  set height(int value) => _height = value;

  ActivityLevel get activityLevel => _activityLevel;
  set activityLevel(ActivityLevel value) => _activityLevel = value;
}
