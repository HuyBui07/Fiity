import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'signupScreen.dart';



class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _email = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future pwreset() async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text.trim());
      showDialog(context: context, builder: (context) {
        return AlertDialog(content: Text('Please check your email.'));
      });
    } on FirebaseAuthException catch (e) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(content: Text(e.message.toString()));
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 73,
            left: 10,
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => LoginScreen())));
              }, 
              icon: const Icon(Icons.arrow_back)
            )
          ),
          Positioned(
            top: 136,
            left: 27,
            child: Text(
              'Forgot Password',
              style: TextStyle( fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black) ,
            )
          ),
          Positioned(
            top: 183,
            left: 27,
            child: Text(
              'Enter your email',
              style: TextStyle( fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black) ,
            )
          ),
          Positioned(
            top: 209,
            left: 27,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 2, 8, 2),
              width: 321,
              height: 49,
              decoration: BoxDecoration(
                color: Color(0xfff2f2f2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color.fromRGBO(76, 17, 244, 1))
              ),
              child: TextField(
                controller: _email,
                decoration: InputDecoration(
                  border: InputBorder.none
                ),
              ),
            )
          ),
          Positioned(
            top: 642,
            left: 27,
            child: GestureDetector(
              onTap: () {
                pwreset();
              },
              child: Container(
                height: 49,
                width: 321,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(76, 17, 244, 1),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text(
                    'Done',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
                  )
                ),
              ),
            )
          ),
          Positioned(
            top: 728,
            left: 68,
            child: Row(
              children: [
                Text(
                  'Do not have an account?',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black)
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignUpScreen())));
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromRGBO(76, 17, 244, 1))
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}