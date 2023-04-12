// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';

enum UsernameComponent {
  firstName,
  lastName,
  fullName,
  age,
  email,
  introFirstName
}

class GetUserInfo extends StatelessWidget {
  final UsernameComponent component;

  GetUserInfo({required this.component});

  @override
  Widget build(BuildContext context) {
    final userUid = FirebaseAuth.instance.currentUser?.uid;
    final DatabaseReference usersRef =
        FirebaseDatabase.instance.ref().child('users/$userUid/user_data');
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Text('User not signed in');
    }

    return StreamBuilder<DatabaseEvent>(
      stream: usersRef.onValue,
      builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
          final dynamic value = snapshot.data!.snapshot.value;
          Map<dynamic, dynamic> userData = value;
          final String firstName =
              userData.containsKey('first name') ? userData['first name'] : '';

          final String lastName =
              userData.containsKey('last name') ? userData['last name'] : '';

          final String email =
              userData.containsKey('email') ? userData['email'] : '';

          final String age =
              userData.containsKey('age') ? userData['age'].toString() : '';

          switch (component) {
            case UsernameComponent.firstName:
              return Text(
                firstName,
                style: GoogleFonts.raleway(
                  fontSize: 16,
                  color: Colors.lightGreen[800],
                  fontWeight: FontWeight.bold,
                ),
              );
            case UsernameComponent.lastName:
              return Text(
                lastName,
                style: GoogleFonts.raleway(
                  fontSize: 16,
                  color: Colors.lightGreen[800],
                  fontWeight: FontWeight.bold,
                ),
              );
            case UsernameComponent.fullName:
              final String fullName = '$firstName $lastName';
              return Text(
                fullName,
                style: GoogleFonts.raleway(
                  fontSize: 16,
                  color: Colors.lightGreen[800],
                  fontWeight: FontWeight.bold,
                ),
              );
            case UsernameComponent.age:
              return Text(
                age,
                style: GoogleFonts.raleway(
                  fontSize: 16,
                  color: Colors.lightGreen[800],
                  fontWeight: FontWeight.bold,
                ),
              );
            case UsernameComponent.email:
              return Text(
                email,
                style: GoogleFonts.raleway(
                  fontSize: 16,
                  color: Colors.lightGreen[800],
                  fontWeight: FontWeight.bold,
                ),
              );
            case UsernameComponent.introFirstName:
              final String introFirstName = 'Hello, $firstName!';
              return Text(
                introFirstName,
                style: GoogleFonts.raleway(
                  fontSize: 36,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              );
          }
        } else {
          return Text('User data not found');
        }
      },
    );
  }
}
