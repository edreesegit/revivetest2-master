// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revivetest2/intro/get_user_info.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Profile',
                style: GoogleFonts.raleway(
                  fontSize: 24,
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Email:',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                color: Colors.lightGreen[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GetUserInfo(component: UsernameComponent.email),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'First Name:',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                color: Colors.lightGreen[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GetUserInfo(component: UsernameComponent.firstName),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Last Name:',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                color: Colors.lightGreen[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GetUserInfo(component: UsernameComponent.lastName),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Age:',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                color: Colors.lightGreen[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GetUserInfo(component: UsernameComponent.age),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Text(
                      'Sign Out',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
