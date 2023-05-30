import 'dart:convert';

import 'package:fitty/Exercises/exercise.dart';
import 'package:fitty/Exercises/exerciseScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class SearchForExercises extends StatefulWidget {
  const SearchForExercises({Key? key}) : super(key: key);

  @override
  State<SearchForExercises> createState() => _SearchForExercisesState();
}

class _SearchForExercisesState extends State<SearchForExercises> {
  late List<Exercise> exercises;
  List<Exercise> filteredExercises = [];

  @override
  void initState() {
    super.initState();
    loadExercises();
  }

  Future<void> loadExercises() async {
    exercises = await ExerciseService.getExercises();
    setState(() {
      filteredExercises = exercises;
    });
  }

  void filterExercises(String searchText) {
    setState(() {
      filteredExercises = exercises.where((exercise) {
        final exerciseName = exercise.name.toLowerCase();
        final searchLower = searchText.toLowerCase();
        return exerciseName.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1f1545),
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color(0xFF1f1545),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search for an exercise",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: filterExercises,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                fillColor: Color(0xff302360),
                filled: true,
                hintText: "Bicep Curls...",
                hintStyle: TextStyle(color: const Color(0x69FFFFFF)),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredExercises.length,
                itemBuilder: (BuildContext context, int index) {
                  final exercise = filteredExercises[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ExerciseDetailsScreen(exercise: exercise),
                        ),
                      );
                    },
                    title: Text(
                      exercise.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      exercise.type,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseService {
  static Future<List<Exercise>> getExercises() async {
    final String jsonString =
        await rootBundle.loadString('assets/exercises.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Exercise.fromJson(json)).toList();
  }
}
