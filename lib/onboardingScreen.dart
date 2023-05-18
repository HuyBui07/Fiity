import 'package:fitty/loginScreen.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/IntroScreen.png"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(27.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Fitty',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10,),
              const Text(
                'Fitty is an app designed to improve fitness experience and help improve your fitness goals faster.',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 40,),
              Center(
                child: Container(
                  width: 170,
                  height: 50,
                  child: RawMaterialButton(
                    fillColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const LoginScreen())));
                    },
                    child: const Text(
                      "Getting started",
                      style: TextStyle(color: Color.fromRGBO(76, 17, 244, 1), fontSize: 17),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }
}
