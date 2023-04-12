// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revivetest2/calibration/heel_slides_calibration_page.dart';
import 'package:revivetest2/calibration/knee_extensions_calibration_page.dart';
import 'package:revivetest2/calibration/squats_calibration_page.dart';

class ExerciseButton extends StatefulWidget {
  final String exerciseName;

  ExerciseButton({Key? key, required this.exerciseName}) : super(key: key);

  @override
  _ExerciseButtonState createState() => _ExerciseButtonState();
}

class _ExerciseButtonState extends State<ExerciseButton> {
  final bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (widget.exerciseName) {
          case 'Squats':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SquatsCalibration()),
            );
            break;
          case 'Heel Slides':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HeelSlidesCalibration()),
            );
            break;
          case 'Knee Extensions':
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => KneeExtensionsCalibration()),
            );
            break;
          default:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SquatsCalibration()),
            );
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: _isTapped ? 85 : 80,
        decoration: BoxDecoration(
          color: Colors.lightGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Begin ${widget.exerciseName}',
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
