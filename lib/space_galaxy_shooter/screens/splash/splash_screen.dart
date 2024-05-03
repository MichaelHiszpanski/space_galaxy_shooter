import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        FloatingActionButton.extended(
          // extended used to create custom Floating Action Button
          onPressed: () => _navigateToPlayGame(context),
          label: Container(
            alignment: Alignment.center,
            height: 300.0,
            width: 300.0,
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
          elevation: 10.0,
        ),
      ],
    ));
  }

  void _navigateToPlayGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
