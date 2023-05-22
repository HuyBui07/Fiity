import 'package:flutter/material.dart';
import 'package:fitty/exercise/muscle_group.dart';
import 'package:fitty/exercise/chooseExercisePage.dart';

class ChooseMuscleGroup extends StatefulWidget {
  @override
  _ChooseMuscleGroupState createState() => _ChooseMuscleGroupState();
}

class _ChooseMuscleGroupState extends State<ChooseMuscleGroup> {
  List<MuscleGroup> muscleGroups = [
    MuscleGroup('Chest', 'chest.png'),
    MuscleGroup('Traps', 'traps.png'),
    MuscleGroup('Shoulders', 'shoulders.png'),
    MuscleGroup('Biceps', 'biceps.png'),
    MuscleGroup('Forearms', 'forearms.png'),
    MuscleGroup('Lats', 'lats.png'),
    MuscleGroup('Abdominals', 'abdominals.png'),
    MuscleGroup('Glutes', 'glutes.png'),
    MuscleGroup('Hamstrings', 'hamstrings.png'),
    MuscleGroup('Obliques', 'obliques.png'),
    MuscleGroup('Quads', 'quads.png'),
    MuscleGroup('Calves', 'calves.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Muscle Group'),
      ),
      body: ListView.builder(
        itemCount: muscleGroups.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChooseExercisePage(
                    muscleGroup: muscleGroups[index],
                  ),
                ),
              );
            },
            leading: Container(
              width: 50,
              height: 50,
              child: Image.asset(
                'assets/muscle/chooseMuscleImage/${muscleGroups[index].imagePath}',
                fit: BoxFit.contain,
              ),
            ),
            title: Text(muscleGroups[index].name),
          );
        },
      ),
    );
  }
}
