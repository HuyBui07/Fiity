import 'package:flutter/material.dart';
import 'exercise.dart';

class ExerciseScreen extends StatefulWidget {
  final List<Exercise> exercises;

  ExerciseScreen({required this.exercises});

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  String _selectedType = 'All';
  String _selectedDifficulty = 'All';

  List<String> _getExerciseTypes() {
    Set<String> typesSet = {'All'};
    for (Exercise exercise in widget.exercises) {
      typesSet.add(exercise.type);
    }
    return typesSet.toList();
  }

  List<String> _getExerciseDifficulties() {
    Set<String> difficultiesSet = {'All'};
    for (Exercise exercise in widget.exercises) {
      difficultiesSet.add(exercise.difficulty);
    }
    return difficultiesSet.toList();
  }

  List<Exercise> _filterExercises() {
    List<Exercise> filteredExercises = List.from(widget.exercises);
    if (_selectedType != 'All') {
      filteredExercises = filteredExercises
          .where((exercise) => exercise.type == _selectedType)
          .toList();
    }
    if (_selectedDifficulty != 'All') {
      filteredExercises = filteredExercises
          .where((exercise) => exercise.difficulty == _selectedDifficulty)
          .toList();
    }
    return filteredExercises;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _selectedType,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedType = newValue!;
                    });
                  },
                  items: _getExerciseTypes().map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: _selectedDifficulty,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedDifficulty = newValue!;
                    });
                  },
                  items: _getExerciseDifficulties().map((difficulty) {
                    return DropdownMenuItem<String>(
                      value: difficulty,
                      child: Text(difficulty),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filterExercises().length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) {
                            return ExerciseDetailsScreen(
                                exercise: _filterExercises()[index]);
                          }));
                    },
                    title: Text(_filterExercises()[index].name),
                    subtitle: Text(_filterExercises()[index].difficulty),
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

class ExerciseDetailsScreen extends StatelessWidget {
  final Exercise exercise;

  ExerciseDetailsScreen({required this.exercise});

  @override
  Widget build(BuildContext context) {
    final gifName = '${exercise.id}.gif';
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                child: Image.asset(
                  'assets/exercises/$gifName',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Muscle: ${exercise.muscle}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Equipment: ${exercise.equipment}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Difficulty: ${exercise.difficulty}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Instructions:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                exercise.instructions,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
