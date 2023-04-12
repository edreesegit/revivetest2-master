import 'package:flutter/material.dart';
import 'package:revivetest2/intro/signIn_page.dart';
import 'package:revivetest2/intro/signUp_page.dart';

class SignInAndUpNavigator extends StatefulWidget {
  const SignInAndUpNavigator({Key? key}) : super(key: key);

  @override
  State<SignInAndUpNavigator> createState() => _SignInAndUpNavigatorState();
}

class _SignInAndUpNavigatorState extends State<SignInAndUpNavigator> {
  bool showSignInPage = true;

  void toggleScreens() {
    setState(() {
      showSignInPage = !showSignInPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignInPage) {
      return SignInPage(showSignUpPage: toggleScreens);
    } else {
      return SignUpPage(showSignInPage: toggleScreens);
    }
  }
}
