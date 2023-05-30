import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'exercise.dart';
import 'exerciseScreen.dart';

class MuscleGroupsScreen extends StatefulWidget {
  @override
  _MuscleGroupsScreenState createState() => _MuscleGroupsScreenState();
}

class _MuscleGroupsScreenState extends State<MuscleGroupsScreen> {
  List<Exercise> _allExercises = [];
  List<String> _musclesList = [];
  List<Exercise> _selectedExercises = [];
  Color textColor = Color(0xFFffffff);
  Color backgroundColor = Color(0xFF000000);
  Color mainButtonColor = Color(0xFF9d34da);
  Color secondaryButtonColor = Color(0xFF1a1a1a);
  Color accentColor = Color(0xFFbd73e8);
  _loadExercises() async {
    String data = await rootBundle.loadString('assets/exercises.json');
    List<dynamic> jsonList = json.decode(data);
    List<Exercise> tempList = [];

    jsonList.forEach((exercise) {
      tempList.add(Exercise.fromJson(exercise));
    });

    setState(() {
      _allExercises = tempList;
      _musclesList = tempList.map((e) => e.muscle).toSet().toList();
      _selectedExercises = tempList;
    });
  }

  _updateSelectedExercises(String muscle) {
    setState(() {
      _selectedExercises =
          _allExercises.where((e) => e.muscle == muscle).toList();
    });

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => ExerciseScreen(exercises: _selectedExercises)),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1f1545),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Muscle groups'),
        backgroundColor: Color(0xFF1f1545),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _musclesList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: ListTile(
                    onTap: () => _updateSelectedExercises(_musclesList[index]),
                    tileColor: Color(0xff302360),
                    title: Align(
                      alignment: Alignment.center,
                      child: Text(
                        FilterMuscleGroupText(_musclesList[index]),
                        style: TextStyle(
                          color: Color.fromARGB(251, 255, 255, 255),
                          fontSize: 20,
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    style: ListTileStyle.list,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

String FilterMuscleGroupText(String text) {
  //upercase first letter and remove "_", replace with spacing
  text = text[0].toUpperCase() + text.substring(1);
  text = text.replaceAll("_", " ");
  return text;
}
