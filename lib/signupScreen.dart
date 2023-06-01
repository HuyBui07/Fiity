import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitty/mainScreen/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import 'loginScreen.dart';

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
  bool isConfirmPasswordCorrect = false;
  bool _obscureText1 = true;
  bool _obscureText2 = true;

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
                obscureText: _obscureText1,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText1 = !_obscureText1;
                        });
                      },
                      child: Icon(_obscureText1
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
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
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    if (val == _password.text) {
                      isConfirmPasswordCorrect = true;
                    } else {
                      isConfirmPasswordCorrect = false;
                    }
                  });
                },
                obscureText: _obscureText2,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText2 = !_obscureText2;
                        });
                      },
                      child: Icon(_obscureText2
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    labelText: "Confirm Password",
                    hintText: 'Reconfirm your password',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: isConfirmPasswordCorrect == false
                                ? Colors.red
                                : Colors.green),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: RawMaterialButton(
                  fillColor: (isEmailCorrect &
                              isPasswordCorrect &
                              isConfirmPasswordCorrect ==
                          false)
                      ? const Color.fromRGBO(76, 17, 244, 0.1)
                      : const Color.fromRGBO(76, 17, 244, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  onPressed: (isEmailCorrect &
                              isPasswordCorrect &
                              isConfirmPasswordCorrect ==
                          false)
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();

                  

                          await FirebaseAuth.instance
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
                                    title: const Text("Error"),
                                    content: Text(err.message),
                                    actions: [
                                      TextButton(
                                        child: const Text("Ok"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          });
                          // ignore: use_build_context_synchronously
                          
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
