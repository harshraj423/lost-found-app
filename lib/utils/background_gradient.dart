import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  final Widget child;
  const BackgroundGradient({super.key, required this.child});

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFFe9defa), // cyan
            Color(0xFFfbfcdb), // purple
          ],
        ),
      ),
      child: child,
    );
  }
}
