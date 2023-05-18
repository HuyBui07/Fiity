import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signupScreen.dart';
import 'mainScreen.dart';
import 'package:validators/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email = TextEditingController();
  late final TextEditingController _password = TextEditingController();
  bool isEmailCorrect = false;
  bool isPasswordCorrect = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(27),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign In",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text("Enter your credentials",
                style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: 20,
            ),
            const Text("Email", style: TextStyle(fontSize: 14)),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              onChanged: (val) {
                setState(() {
                  isEmailCorrect = isEmail(val);
                });
              },
              controller: _email,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: isEmailCorrect == false
                              ? Colors.red
                              : Colors.green),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10)))),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Password", style: TextStyle(fontSize: 14)),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  if (value.length < 6) {
                      isPasswordCorrect = false;
                    } else {
                      isPasswordCorrect = true;
                    }
                });
              },
              controller: _password,
              autocorrect: false,
              enableSuggestions: false,
              obscureText: true,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: isPasswordCorrect == false
                              ? Colors.red
                              : Colors.green),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10)))),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: isEmailCorrect & isPasswordCorrect == false
                    ? const Color.fromRGBO(76, 17, 244, 0.1)
                    : const Color.fromRGBO(76, 17, 244, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                onPressed: isEmailCorrect & isPasswordCorrect == false
                    ? null
                    : () {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _email.text, password: _password.text)
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const MainScreen())));
                        }).catchError((err) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text(err.message),
                                  actions: [
                                    TextButton(
                                      child: Text("Ok"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        });
                      },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Do not have an account?',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black)),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const SignUpScreen())));
                  },
                  child: const Text('Sign Up',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xff006175))),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
