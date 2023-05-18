import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mainScreen.dart';
import 'package:validators/validators.dart';

final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create your account',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 60,
              ),
              TextFormField(
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.man_sharp),
                    hintText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    isEmailCorrect = isEmail(val);
                  });
                },
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: 'SomeThing@gmail.com',
                    prefixIcon: Icon(Icons.email),
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
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    if (val.length < 6) {
                      isPasswordCorrect = false;
                    } else {
                      isPasswordCorrect = true;
                    }
                  });
                },
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: 'At least 6 characters',
                    prefixIcon: Icon(Icons.lock),
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
                height: 30,
              ),
              Container(
                width: double.infinity,
                child: RawMaterialButton(
                  fillColor:
                      (isEmailCorrect & isPasswordCorrect == false)
                          ? const Color.fromRGBO(76, 17, 244, 0.1)
                          : const Color.fromRGBO(76, 17, 244, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  onPressed: (isEmailCorrect & isPasswordCorrect == false)
                      ? null
                      : () {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _email.text, password: _password.text)
                              .then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const MainScreen())));
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
                    "Sign up",
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
                  const Text('Already have an account?',
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
                              builder: ((context) => const LoginScreen())));
                    },
                    child: const Text('Sign In',
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
      ),
    );
  }
}
