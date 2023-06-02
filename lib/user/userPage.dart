import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitty/user/editInformationPage.dart';
import 'package:fitty/user/user.dart';
import 'package:flutter/material.dart';
import 'globals.dart';
import 'package:fitty/mainScreen/nutrition/nutrient.dart';


class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String name = "";
  String age = "";
  String height = "";
  String weight = "";
  String gender = "";
  String activityLevel = "";
  String infoPath = "";

  @override
  void initState() {
    super.initState();

    setNameFromUserFile();
  }

  Future<void> setInfoPath() async {
    infoPath = await UserLocal.getInfoPath();
  }

  Future<void> setNameFromUserFile() async {
    await setInfoPath();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    try {
      final file;
      if (await File(infoPath).exists()) {
        file = File(infoPath);
      } else {
        print("File doesn't exist");
        return;
      }

      String? userName;
      String? userAge;
      String? userHeight;
      String? userWeight;
      String? userGender;
      String? userActivityLevel;
      double? userCalories;

      if (await file.exists()) {
        final jsonData = await file.readAsString();
        final userMap = jsonDecode(jsonData) as Map<String, dynamic>;
        userName = userMap['name'] as String?;
        userAge = userMap['age'].toString();
        userHeight = userMap['height'].toString();
        userGender = userMap['gender'].toString();
        userWeight = userMap['weight'].toString();
        userActivityLevel = userMap['activityLevel'].toString();
        userCalories = NutrientCalculator.calculateCalories(
        double.tryParse(UserLocal().weight.toString())!,
        double.tryParse(UserLocal().height.toString())!,
        UserLocal().activityLevel,
        UserLocal().gender);
      }



      setState(() {
        name = userName ?? "Unknown";
        age = userAge ?? "Unknown";
        height = userHeight ?? "Unknown";
        weight = userWeight ?? "Unknown";
        gender = userGender ?? "Unknown";
        calories = userCalories ?? 0;
        switch (userActivityLevel) {
          case "littleNoExercise":
            activityLevel = "Little exercise";
            break;
          case "oneTwoTimesWeek":
            activityLevel = "1-2 times/week";
            break;
          case "twoThreeTimesWeek":
            activityLevel = "2-3 times/week";
            break;
          case "threeFiveTimesWeek":
            activityLevel = "3-5 times/week";
            break;
          case "sixSevenTimesWeek":
            activityLevel = "6-7 times/week";
            break;
          case "professionalAthlete":
            activityLevel = "Professional athlete";
            break;

          default:
            activityLevel = "Unknown";
            break;
        }
      });
    } catch (e) {
      print('Failed to read user information: $e');
    }
  }

  Future<void> navigateToEditInfo() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditInformationPage()),
    );
    setNameFromUserFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF1f1545),
        elevation: 0.0,
        //Add an edit info button on top right
        actions: [
          IconButton(
            onPressed: () {
              navigateToEditInfo();
            },
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFF1f1545),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/UserIcon.png'),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Row(
                  children: [
                    Text(
                      "Name:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Row(
                  children: [
                    Text(
                      "Age:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      age,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Row(
                  children: [
                    Text(
                      "Height:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      height,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      " cm",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Row(
                  children: [
                    Text(
                      "Weight: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      weight,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      " KG",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Row(
                  children: [
                    Text(
                      "Gender: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      gender,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Row(
                  children: [
                    Text(
                      "Activity:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Text(
                        activityLevel,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Row(
                  children: [
                    Text(
                      "Calories/day:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Text(
                        calories.round().toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF7B5AF4),
                  ),
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    print('Sign out');
                    Navigator.pop(context);
                  });
                },
                child: Text("Log out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
