import 'package:flutter/material.dart';
import 'package:fitty/exercise/muscle_group.dart';

class ChooseExercisePage extends StatelessWidget {
  final MuscleGroup muscleGroup;

  ChooseExercisePage({required this.muscleGroup});

  List<Exercise> exercises = [
    Exercise(
      id: 1,
      name: 'Exercise 1',
      muscleGroup: MuscleGroup('Chest', 'chest.png'),
      difficulty: 'Beginner',
      gif: 'chest.png',
      instruction: 'Exercise 1 Instruction',
    ),
    Exercise(
      id: 2,
      name: 'Exercise 2',
      muscleGroup: MuscleGroup('Chest', 'chest.png'),
      difficulty: 'Intermediate',
      gif: 'chest.png',
      instruction: 'Exercise 2 Instruction',
    ),
    // Add more exercises for the muscle group
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${muscleGroup.name} Exercises'),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                width: 50,
                height: 50,
                child: Image.asset(
                  'assets/muscle/chooseMuscleImage/${exercises[index].gif}',
                  fit: BoxFit.contain,
                ),
              ),
              title: Text(exercises[index].name),
              subtitle: Text('Difficulty: ${exercises[index].difficulty}'),
            );
          },
        ),
      ),
    );
  }
}

class Exercise {
  final int id;
  final String name;
  final MuscleGroup muscleGroup;
  final String difficulty;
  final String gif;
  final String instruction;

  Exercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.difficulty,
    required this.gif,
    required this.instruction,
  });
}
