import 'package:flutter/material.dart';

// Created a common navigation helper to use everytime
class NavigationHelper {
  static void push(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

// Push with named Routes
  static void pushNamed(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  // Replace current screen
  static void pushReplacement(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

// Pop the current screen
  static void pop(BuildContext context, {dynamic result}) {
    Navigator.pop(context, result);
  }

// Push and remove all previous screens
  static void pushAndRemoveUntil(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false, // Remove all previous routes
    );
  }
}
