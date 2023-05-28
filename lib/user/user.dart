import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitty/mainScreen/nutrition/nutrient.dart';
import 'package:path_provider/path_provider.dart';

class UserLocal {
  int? id;
  Gender _gender;
  String _name;
  int _age;
  int _weight; // In kilograms
  int _height; // In centimeters
  ActivityLevel _activityLevel;
  //Should be default path. file name = "user_info_uid.json"
  static String infoPath =
      getApplicationDocumentsDirectory().toString() + "/user_info_uid.json";
  UserLocal({
    this.id,
    String name = "User",
    Gender gender = Gender.male,
    int age = 18,
    int weight = 45,
    int height = 170,
    ActivityLevel activityLevel = ActivityLevel.littleNoExercise,
  })  : _gender = gender,
        _age = age,
        _weight = weight,
        _height = height,
        _activityLevel = activityLevel,
        _name = name;

  Gender get gender => _gender;
  set gender(Gender value) => _gender = value;

  int get age => _age;
  set age(int value) => _age = value;

  int get weight => _weight;
  set weight(int value) => _weight = value;

  int get height => _height;
  set height(int value) => _height = value;
  ActivityLevel get activityLevel => _activityLevel;

  String get name => _name;
  set name(String value) => _name = value;
  static Future<String> getInfoPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    return '${directory.path}/user_info_${user!.uid}.json';
  }

  Future<void> saveUserToFile(UserLocal user) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(await getInfoPath());

    try {
      final jsonData = jsonEncode(user.toJson());

      await file.writeAsString(jsonData);

      print('User information saved to file: ${file.path}');
      infoPath = file.path;
      String contentFromFile = await file.readAsString();
      print("Info saved:\n" + contentFromFile);
    } catch (e) {
      print('Failed to save user information: $e');
    }
  }

  static UserLocal userFromJson(Map<String, dynamic> json) {
    return UserLocal(
      age: json['age'],
      weight: json['weight'],
      height: json['height'],
      activityLevel: Ultis.activityLevelFromString(json['activityLevel']),
      gender: Ultis.genderFromString(json['gender']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'gender': _gender.toString().split('.').last,
      'age': _age,
      'weight': _weight,
      'height': _height,
      'activityLevel': _activityLevel.toString().split('.').last,
    };
  }
}
