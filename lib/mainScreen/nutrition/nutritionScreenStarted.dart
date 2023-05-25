import 'package:fitty/mainScreen/nutrition/calculateNutritionPage.dart';
import 'package:fitty/transition/fadeRoute.dart';
import 'package:flutter/material.dart';
//NutritionScreen structure: Welcome ->  Calculate nutritionn ->  Show nutritionn

class NutritionScreenStarted extends StatelessWidget {
  NutritionScreenStarted({Key? key});
  final Color mainColor = const Color(0xff8e5732);
  final Color secondaryColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: OrientationBuilder(
        builder: (context, orientation) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
                vertical: MediaQuery.of(context).size.height * 0.1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.03,
                      ),
                      child: Text(
                        "Nutrition Calculator",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.03,
                    ),
                    height: MediaQuery.of(context).size.height *
                        (orientation == Orientation.portrait ? 0.4 : 0.6),
                    width: MediaQuery.of(context).size.width *
                        (orientation == Orientation.portrait ? 0.8 : 0.4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image(
                        image:
                            AssetImage('assets/nutrition/nutritionStart.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        "See how much nutrients you need!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            FadeRoute(
                              page: NutritionCalculateScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Calculate",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.015,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.08,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
