import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  EdgeInsets buttonPadding = EdgeInsets.all(8.0);

  int _selectedIndex = 0; // Selected tab index

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.transparent,
            margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Hello, ",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "User!",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w700),
                          ),
                        )
                      ]),
                      SizedBox(
                        height: 5,
                      ),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "What is your goal today?",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        )
                      ]),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                    Colors.transparent,
                                  ),
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent,
                                  ),
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.zero,
                                  ),
                                ),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8 +
                                          10,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xffa7a2ff),
                                        Color(0xff00d4ff)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/IntroScreen.png',
                                      ),
                                      fit: BoxFit.fill,
                                      opacity: 0.2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: buttonPadding,
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        'Workout exercises',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                    Colors.transparent,
                                  ),
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent,
                                  ),
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.zero,
                                  ),
                                ),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xff00d4ff),
                                        Color(0xffee4f64)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/IntroScreen.png',
                                      ),
                                      fit: BoxFit.fill,
                                      opacity: 0.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: buttonPadding,
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        'Nutrition Calculator',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                    Colors.transparent,
                                  ),
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent,
                                  ),
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.zero,
                                  ),
                                ),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xffa7a2ff),
                                        Color(0xff00d4ff)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/IntroScreen.png',
                                      ),
                                      fit: BoxFit.fill,
                                      opacity: 0.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: buttonPadding,
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        'Hydration Reminder',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
