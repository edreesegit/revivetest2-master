// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revivetest2/intro/forgot_password.dart';

class SignInPage extends StatefulWidget {
  final VoidCallback showSignUpPage;
  const SignInPage({Key? key, required this.showSignUpPage}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    try {
      // Attempt to sign in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // If sign-in is successful, dismiss the loading circle and navigate to home page
      Navigator.of(context).pop();
    } on FirebaseAuthException {
      // If sign-in fails, dismiss the loading circle and show error message
      await Future.delayed(Duration(milliseconds: 500));
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Sign-in failed!',
              style: GoogleFonts.raleway(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Could not sign in. Please check your email and password and try again.',
              style: GoogleFonts.raleway(
                fontSize: 18,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    textStyle: GoogleFonts.raleway(
                      fontSize: 24,
                    ),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey),
                  ),
                  child: Text('OK')),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ReviveApp',
                style: GoogleFonts.raleway(
                  fontSize: 50,
                  color: Colors.lightGreen[800],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Track your next steps towards recovery.',
                style: GoogleFonts.raleway(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 30),

              // email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightGreen),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Email',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10),

              // password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightGreen),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Password',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ForgotPasswordPage();
                          }),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.raleway(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ElevatedButton(
                  onPressed: signIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: Size(double.infinity, 0),
                  ),
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a Member?',
                    style: GoogleFonts.raleway(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showSignUpPage,
                    child: Text(
                      ' Register now!',
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
    // email textfield

    // password textfield

    // sign in button

    // registerButton (not a member? register now!)
  }
}
