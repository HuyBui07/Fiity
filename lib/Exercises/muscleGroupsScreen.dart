import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

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
      _selectedExercises = _allExercises.where((e) => e.muscle == muscle).toList();
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ExerciseScreen(exercises: _selectedExercises)),
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
      appBar: AppBar(
        title: const Text('Muscle Groups'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _musclesList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () => _updateSelectedExercises(_musclesList[index]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(_musclesList[index]),
                    ),
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
