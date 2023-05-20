import 'package:flutter/material.dart';
import 'package:fitty/nutrition/nutrient.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NutritionCalculateScreen extends StatefulWidget {
  @override
  _NutritionCalculateScreenState createState() =>
      _NutritionCalculateScreenState();
}

class _NutritionCalculateScreenState extends State<NutritionCalculateScreen> {
  final Color mainColor = const Color(0xff8e5732);
  final Color secondaryColor = Colors.white;
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  ActivityLevel selectedActivityLevel = ActivityLevel.littleNoExercise;
  Gender selectedGender = Gender.male;

  List<DRIResult> driResults = [];
  bool isLoading = false;
  bool firstTimeLoad = true;

  void calculateDRI() {
    setState(() {
      isLoading = true;
      firstTimeLoad = false;
    });

    NutrientCalculator.calculateDRI(
      age: ageController.text,
      weight: weightController.text,
      height: heightController.text,
      selectedActivityLevel: selectedActivityLevel,
      selectedGender: selectedGender,
      driResults: driResults,
    );

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  bool isValidNumber(String text) {
    final value = double.tryParse(text);
    return value != null && value > 0;
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          appBar: AppBar(
            title: Text('DRI Calculator'),
            centerTitle: true,
            backgroundColor: mainColor,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: ageController,
                    decoration: InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: weightController,
                    decoration: InputDecoration(labelText: 'Weight (kg)'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: heightController,
                    decoration: InputDecoration(labelText: 'Height (cm)'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        'Gender:',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 16.0),
                      Row(
                        children: [
                          Radio<Gender>(
                            value: Gender.male,
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value!;
                              });
                            },
                          ),
                          Text('Male'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<Gender>(
                            value: Gender.female,
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value!;
                              });
                            },
                          ),
                          Text('Female'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<ActivityLevel>(
                    value: selectedActivityLevel,
                    onChanged: (value) {
                      setState(() {
                        selectedActivityLevel = value!;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: ActivityLevel.littleNoExercise,
                        child: Text('Little/No exercise'),
                      ),
                      DropdownMenuItem(
                        value: ActivityLevel.oneTwoTimesWeek,
                        child: Text('1-2 times a week'),
                      ),
                      DropdownMenuItem(
                        value: ActivityLevel.twoThreeTimesWeek,
                        child: Text('2-3 times a week'),
                      ),
                      DropdownMenuItem(
                        value: ActivityLevel.threeFiveTimesWeek,
                        child: Text('3-5 times a week'),
                      ),
                      DropdownMenuItem(
                        value: ActivityLevel.sixSevenTimesWeek,
                        child: Text('6-7 times a week'),
                      ),
                      DropdownMenuItem(
                        value: ActivityLevel.professionalAthlete,
                        child: Text('Professional athlete'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (isValidNumber(ageController.text) &&
                                isValidNumber(weightController.text) &&
                                isValidNumber(heightController.text)) {
                              calculateDRI();
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Invalid Values'),
                                    content: Text(
                                        'Please enter valid non-zero numbers.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                    child:
                        isLoading //Epic animation. No loading time, only illusion
                            ? SpinKitThreeBounce(
                                color: secondaryColor,
                                size: 20.0,
                                duration: Duration(seconds: 1),
                              )
                            : Text(
                                'Calculate',
                                style: TextStyle(
                                  color: secondaryColor,
                                ),
                              ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  AnimatedOpacity(
                    opacity: isLoading || firstTimeLoad ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 500),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: driResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            driResults[index].nutrient,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'DRI: ${driResults[index].value.toStringAsFixed(2)} ${driResults[index].unit}',
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
