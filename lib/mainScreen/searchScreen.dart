import 'package:flutter/material.dart';

class SearchForExercises extends StatefulWidget {
  const SearchForExercises({super.key});

  @override
  State<SearchForExercises> createState() => _SearchForExercisesState();
}

class _SearchForExercisesState extends State<SearchForExercises> {
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
            SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(
                fillColor: Color(0xff302360),
                filled: true,
                hintText: "Bicep Curls...",
                hintStyle: TextStyle(
                  color: const Color(0x69FFFFFF),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
