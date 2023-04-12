// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revivetest2/widgets/exercise_button.dart';

class HeelSlidesDirections extends StatelessWidget {
  final String exerciseName;

  HeelSlidesDirections({Key? key, required this.exerciseName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 10),
                  Text(
                    exerciseName,
                    style: GoogleFonts.raleway(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Directions:',
                              style: GoogleFonts.raleway(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightGreen[900],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '• Lie on your back with your knees bent and feet flat on the ground.',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightGreen[800],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '• Slowly slide your right heel away from your body, straightening your leg as much as possible without lifting your foot off the ground.',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightGreen[800],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '• Hold the position for a few seconds, then slowly slide your heel back towards your body.',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightGreen[800],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '• Remember to keep your movements slow and controlled, and to breathe regularly throughout the exercise.',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightGreen[800],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '• Stop when your thighs are parallel to the ground or lower, then push up through your heels to return to the starting position.',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightGreen[800],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '• Remember to keep your movements slow and controlled, and to breathe regularly throughout the exercise.',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightGreen[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              ExerciseButton(
                exerciseName: exerciseName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
