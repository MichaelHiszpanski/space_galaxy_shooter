import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_galaxy_shooter/main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/ui/custom_floating_button/custom_floating_button.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/feature_register/feature_register_screen.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/login/login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool isLoginViewVisible = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoginViewVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentMobileScreenSize =
        MediaQuery.of(context).size; //detect mobile screen size
    ref.read(mobileScreenSizeProvider.notifier).state = currentMobileScreenSize;
    final screenSize = ref.watch(mobileScreenSizeProvider);
    return SafeArea(
        child: Expanded(
      child: Column(
        children: [
          Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/splash.png"),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                const SizedBox(
                  height: 500.0,
                ),
                if (isLoginViewVisible)
                  CustomFloatingButton(
                    onPressed: () => _navigateToLoginScreen(context),
                    buttonName: "Login",
                    heroTag: "tag_spalsh_screen_login",
                  ),
                const SizedBox(
                  height: 50.0,
                ),
                if (isLoginViewVisible)
                  CustomFloatingButton(
                    onPressed: () => _navigateToRegisterScreen(context),
                    buttonName: "Register",
                    heroTag: "tag_spalsh_screen_register",
                  )
              ],
            ),
          )
        ],
      ),
    ));
  }

  void _navigateToLoginScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _navigateToRegisterScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }
}
