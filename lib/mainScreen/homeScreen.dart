import 'dart:convert';
import 'dart:io';

import 'package:fitty/Exercises/muscleGroupsScreen.dart';
import 'package:fitty/mainScreen/hydrationAlarmPage.dart';
import 'package:fitty/mainScreen/nutrition/nutritionScreenStarted.dart';
import 'package:fitty/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:fitty/user/globals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  EdgeInsets buttonPadding = EdgeInsets.all(8.0);
  String userName = "";
  String infoPath = "";
  int _selectedIndex = 0; // Selected tab index

  @override
  void initState() {
    super.initState();
    InitializeName();
  }

  Future<void> setInfoPath() async {
    infoPath = await UserLocal.getInfoPath();
  }

  Future<void> InitializeName() async {
    await setInfoPath();
    final file = File(infoPath);
    if (await file.existsSync()) {
      final jsonData = await file.readAsString();
      final jsonMap = jsonDecode(jsonData);
      userName = jsonMap["name"];
    } else if (userName == "User") {
      await _promptUserName();
    } else {
      // Empty profile
      await _promptUserName();
    }
    setState(() {});
  }

  Future<void> _promptUserName() async {
    final TextEditingController _nameController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('What should we call you?\n(8 characters max)'),
          content: TextField(
            controller: _nameController,
            inputFormatters: [
              LengthLimitingTextInputFormatter(8),
            ],
            decoration: InputDecoration(
              hintText: 'Name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final name = _nameController.text;
                if (name.isNotEmpty) {
                  setState(() {
                    userName = name;
                  });
                  final user = UserLocal(name: name);
                  user.saveUserToFile(user);
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _promptCaloriesChange() async {
    final TextEditingController _caloriesController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Input your meals calories'),
          content: TextField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            controller: _caloriesController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
            ],
            decoration: InputDecoration(
              hintText: 'Calories',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  if (caloriesaday - double.parse(_caloriesController.text)>
                      0) {
                    caloriesaday = calories;
                  } else {
                    caloriesaday -= double.parse(_caloriesController.text);
                  }
                });

                Navigator.pop(context);
              },
              child: Text('Subtract'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (caloriesaday >
                      calories - double.parse(_caloriesController.text)) {
                    caloriesaday = calories;
                  } else {
                    caloriesaday += double.parse(_caloriesController.text);
                  }
                });
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1f1545),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
          children: [
            Center(
              child: Column(
                children: [
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Hello, ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userName,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700),
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
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFFA5A5A5)),
                        ),
                      ),
                    )
                  ]),
                  SizedBox(
                    height: 30,
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => MuscleGroupsScreen()),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.zero,
                              ),
                            ),
                            child: Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.8 + 10,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0x00F0EFF9),
                                    Color(0xFF0000FF)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                image: DecorationImage(
                                  image: AssetImage('assets/WorkoutMan.jpg'),
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
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) =>
                                      NutritionScreenStarted()),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.zero,
                              ),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0x72F6FAFB),
                                    Color(0xFFF3334D)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/nutrition/nutritionStart.png',
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => HydrationAlarmPage()),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.zero,
                              ),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0x0FFFFFFF),
                                    Color(0xFF089EF5)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/HydrationAlarm.jpg'),
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
                  const SizedBox(height: 17),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    CircularPercentIndicator(
                      lineWidth: 10,
                      radius: 50,
                      progressColor: Colors.deepPurple,
                      backgroundColor: Colors.deepPurple.shade100,
                      percent: caloriesaday / calories,
                      center: GestureDetector(
                        onTap: () {
                          setState(() {
                            _promptCaloriesChange();
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(25)),
                          child: Icon(
                            Icons.bolt,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserNamePrompt extends StatefulWidget {
  final Function(String) onNameSubmitted;

  const UserNamePrompt({Key? key, required this.onNameSubmitted})
      : super(key: key);

  @override
  _UserNamePromptState createState() => _UserNamePromptState();
}

class _UserNamePromptState extends State<UserNamePrompt> {
  late TextEditingController _nameController;
  late FocusNode _nameFocusNode;
  final int maxNameLength = 10;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _nameFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter your name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(maxNameLength),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                  onSubmitted: (value) {
                    _submitName();
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _submitName,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitName() {
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      widget.onNameSubmitted(name);
      _nameController.clear();
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
