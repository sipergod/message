import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor.withOpacity(1.0),
      body: Center(
        child: Image.asset(
          'assets/ic_launcher.png',
        ),
      ),
    );
  }
}
