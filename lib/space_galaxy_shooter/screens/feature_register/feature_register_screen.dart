import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_galaxy_shooter/main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/ui/custom_floating_button/custom_floating_button.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/ui/outlined_text_field/outlined_text_field.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/database/mongo_db.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/login/login_screen.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController _userLogin = TextEditingController();
  final TextEditingController _userPassword = TextEditingController();

  void _loginUser() async {
    var dbService = DatabaseService();
    Map<String, dynamic> registerResult = await dbService.addNewUser(
      _userLogin.text,
      _userPassword.text,
    );

    if (registerResult['success']) {
      _navigateToLoginScreen(context);
    } else {
      print('Login failed: ${registerResult['message']}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = ref.watch(mobileScreenSizeProvider);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/register_screen2.png"),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                const SizedBox(
                  height: 200.0,
                ),
                const Text(
                  'Register Account',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 80.0,
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
                  inputvalue: _userPassword,
                ),
                const SizedBox(
                  height: 80.0,
                ),
                CustomFloatingButton(
                  onPressed: () => _loginUser(),
                  buttonName: "Register",
                  heroTag: "tag_register_screen",
                )
              ],
            )),
      )),
    );
  }

  void _navigateToLoginScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    _userLogin.dispose();
    _userPassword.dispose();
    super.dispose();
  }
}
