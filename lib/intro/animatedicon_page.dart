// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:revivetest2/auth/main_navigator.dart';

class AnimatedIconPage extends StatefulWidget {
  const AnimatedIconPage({Key? key}) : super(key: key);

  @override
  _AnimatedIconPageState createState() => _AnimatedIconPageState();
}

class _AnimatedIconPageState extends State<AnimatedIconPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.scale(
          scale: 6,
          child: Lottie.network(
            'https://assets2.lottiefiles.com/packages/lf20_W5Sk67.json',
            controller: _controller,
            onLoaded: (composition) {
              // Configure the AnimationController with the duration of the
              // Lottie file and start the animation.
              _controller
                ..duration = composition.duration
                ..forward()
                ..addListener(() {
                  if (_controller.isCompleted) {
                    // Navigate to the main page when the animation finishes.
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => MainPage()),
                    );
                  }
                });
            },
          ),
        ),
      ),
    );
  }
}
