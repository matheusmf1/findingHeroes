import 'package:finding_heroes/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new LoginPage(),
        image: new Image(image: AssetImage("assets/images/logo.png")),
        backgroundColor: Color.fromARGB(255, 132, 187, 189),
        photoSize: 120.0,
        loaderColor: Colors.white,
    );
  }
}
