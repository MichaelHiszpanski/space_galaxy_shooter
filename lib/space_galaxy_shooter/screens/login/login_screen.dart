import 'package:flutter/material.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/ui/custom_floating_button/custom_floating_button.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/ui/outlined_text_field/outlined_text_field.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/database/mongo_db.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_utils/game_config/game_configuration.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/game_play/game_play_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<dynamic> _users = [];
  final TextEditingController _userLogin = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void _loginUser() async {
    _navigateToPlayGame(context);
    // var dbService = DatabaseService();
    // Map<String, dynamic> loginResult =
    //     await dbService.checkUserLoginAndPassword(
    //   _userLogin.text,
    //   _passwordController.text,
    // );

    // if (loginResult['success']) {
    //   _navigateToPlayGame(context);
    // } else {
    //   print('Login failed: ${loginResult['message']}');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Container(
                width: Config.gameScreenSize,
                height: Config.gameScreenSize,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/login.png"),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 200.0,
                    ),
                    const Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 74,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    OutlinedTextField(
                      labelText: "Login",
                      hintText: "Enter login details",
                      inputvalue: _userLogin,
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    OutlinedTextField(
                      labelText: "Password",
                      hintText: "Enter password coretly",
                      inputvalue: _passwordController,
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    CustomFloatingButton(
                        onPressed: () => _loginUser(), buttonName: "Login")
                  ],
                ))
          ],
        ),
      )),
    );
  }

  void _navigateToPlayGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GamePlayScreen()),
    );
  }

  @override
  void dispose() {
    _userLogin.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
