import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF1f1545),
        elevation: 0.0,
      ),
      backgroundColor: Color(0xFF1f1545),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/WorkoutMan.jpg'),
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
                      " John Cena",
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
