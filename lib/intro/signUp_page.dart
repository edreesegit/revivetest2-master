// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_const_literals_to_create_immutables,

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback showSignInPage;
  const SignUpPage({Key? key, required this.showSignInPage}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();

    super.dispose();
  }

  Future signUp() async {
    try {
      // Check if age is a valid number
      int? age = int.tryParse(_ageController.text.trim());
      if (age == null) {
        throw FormatException('Invalid age');
      }
      // Check if any of the user information is null
      if (_firstNameController.text.trim().isEmpty ||
          _lastNameController.text.trim().isEmpty ||
          _emailController.text.trim().isEmpty ||
          _passwordController.text.trim().isEmpty ||
          _confirmPasswordController.text.trim().isEmpty ||
          _ageController.text.trim().isEmpty) {
        throw Exception('Please fill in all the fields');
      }

      // Check if passwords match
      if (_passwordController.text.trim() !=
          _confirmPasswordController.text.trim()) {
        throw Exception('Passwords do not match');
      }

      if (passwordConfirmed()) {
        // creates the user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
      addUserDetails(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _emailController.text.trim(),
        age,
      );
      showSignUpSuccessDialog();
    } on FormatException catch (e) {
      // Handle invalid age error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(e.toString()),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        },
      );
    } on Exception catch (e) {
      // Handle passwords not matching error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(e.toString()),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  Future<void> addUserDetails(
      String firstName, String lastName, String email, int age) async {
    final userUid = FirebaseAuth.instance.currentUser?.uid;
    DatabaseReference userRef =
        FirebaseDatabase.instance.ref('users/$userUid/user_data');
    final userData = {
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'age': age,
    };
    await userRef.set(userData);
  }

  Future showSignUpSuccessDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.lightGreen,
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(
                      'Sign-up successful!',
                      style: GoogleFonts.raleway(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'You have successfully signed up. Please log in to continue.',
                      style: GoogleFonts.raleway(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // dismiss the dialog box
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: GoogleFonts.raleway(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        'OK',
                        style: GoogleFonts.raleway(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
                ),
              ));
        });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
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
                'New Member?',
                style: GoogleFonts.raleway(
                  fontSize: 50,
                  color: Colors.lightGreen[800],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Register with your information below!',
                style: GoogleFonts.raleway(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 30),

              // first name textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightGreen),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'First Name',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10),

              // last name textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightGreen),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Last Name',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10),

              // age textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightGreen),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Age',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10),
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

              // confirmpassword textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  obscureText: true,
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightGreen),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'Confirm Password',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: Size(double.infinity, 0),
                  ),
                  child: Text(
                    'Sign Up',
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
                    'Already a member?',
                    style: GoogleFonts.raleway(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showSignInPage,
                    child: Text(
                      ' Login now!',
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
  }
}
