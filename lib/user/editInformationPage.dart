import 'package:fitty/mainScreen/nutrition/nutrient.dart';
import 'package:fitty/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditInformationPage extends StatefulWidget {
  const EditInformationPage({Key? key}) : super(key: key);

  @override
  State<EditInformationPage> createState() => _EditInformationPageState();
}

class _EditInformationPageState extends State<EditInformationPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  String _selectedGender = Gender.male.toString().split('.').last;
  ActivityLevel _selectedActivityLevel = ActivityLevel.littleNoExercise;
  Color textColor = Color(0xFFffffff);
  Color backgroundColor = Color(0xFF1f1545);
  Color mainButtonColor = Color(0xFF9d34da);
  Color secondaryButtonColor = Color(0xFF1a1a1a);
  Color accentColor = Color(0xFFbd73e8);
  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void saveUserInfo() {
    UserLocal user = UserLocal(
      name: _nameController.text,
      age: int.tryParse(_ageController.text) ?? 0,
      height: int.tryParse(_heightController.text) ?? 0,
      weight: int.tryParse(_weightController.text) ?? 0,
      gender: _selectedGender == 'male' ? Gender.male : Gender.female,
      activityLevel: _selectedActivityLevel,
    );
    user.saveUserToFile(user);

    // Go back to the user page
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Edit Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: textColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFbd73e8)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: mainButtonColor),
                ),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(8),
              ],
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3)
              ],
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Age',
                labelStyle: TextStyle(color: textColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFbd73e8)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: mainButtonColor),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height (cm)',
                labelStyle: TextStyle(color: textColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFbd73e8)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: mainButtonColor),
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3)
              ],
            ),
            SizedBox(height: 16.0),
            TextFormField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              controller: _weightController,
              keyboardType: TextInputType.number,
              //change text color to white

              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                labelStyle: TextStyle(color: textColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFbd73e8)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: mainButtonColor),
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3)
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Gender:',
              style: TextStyle(fontSize: 16.0, color: textColor),
            ),
            RadioListTile<String>(
              title: Text('Male',
                  style: TextStyle(fontSize: 16.0, color: textColor)),
              value: Gender.male.toString().split('.').last,
              groupValue: _selectedGender,
              fillColor: MaterialStateProperty.all<Color>(Color(0xFF7B5AF4)),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Female',
                  style: TextStyle(fontSize: 16.0, color: textColor)),
              value: Gender.female.toString().split('.').last,
              fillColor: MaterialStateProperty.all<Color>(Color(0xFF7B5AF4)),
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Activity Level:',
              style: TextStyle(fontSize: 16.0, color: textColor),
            ),
            DropdownButtonFormField<ActivityLevel>(
              value: _selectedActivityLevel,
              onChanged: (value) {
                setState(() {
                  _selectedActivityLevel = value!;
                });
              },
              dropdownColor: backgroundColor,
              items: [
                DropdownMenuItem(
                    value: ActivityLevel.littleNoExercise,
                    child: Text('Little/No exercise',
                        style: TextStyle(color: textColor))),
                DropdownMenuItem(
                  value: ActivityLevel.oneTwoTimesWeek,
                  child: Text('1-2 times a week',
                      style: TextStyle(color: textColor)),
                ),
                DropdownMenuItem(
                  value: ActivityLevel.twoThreeTimesWeek,
                  child: Text('2-3 times a week',
                      style: TextStyle(color: textColor)),
                ),
                DropdownMenuItem(
                  value: ActivityLevel.threeFiveTimesWeek,
                  child: Text('3-5 times a week',
                      style: TextStyle(color: textColor)),
                ),
                DropdownMenuItem(
                  value: ActivityLevel.sixSevenTimesWeek,
                  child: Text('6-7 times a week',
                      style: TextStyle(color: textColor)),
                ),
                DropdownMenuItem(
                  value: ActivityLevel.professionalAthlete,
                  child: Text('Professional athlete',
                      style: TextStyle(color: textColor)),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF7B5AF4)), // background
              ),
              onPressed: () {
                final String name = _nameController.text.trim();
                final String age = _ageController.text.trim();
                final String height = _heightController.text.trim();
                final String weight = _weightController.text.trim();

                if (name.isEmpty ||
                    age.isEmpty ||
                    height.isEmpty ||
                    weight.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Missing Information'),
                        content:
                            Text('Please fill in all the required fields.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  final int enteredAge = int.tryParse(age) ?? 0;
                  if (enteredAge > 100) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirmation'),
                          content: Text(
                              'Are you sure you want to enter an age above 100?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                                // Proceed with saving the information
                                saveUserInfo();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Proceed with saving the information
                    saveUserInfo();
                  }
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
