import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_main/game_main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/game_play/game_play_screen.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/login/login_screen.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/menu/menu_screen.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/splash/splash_screen.dart';

final userLoginProvider = StateProvider<dynamic>((ref) => null);
final allUsersDataProvider = StateProvider<dynamic>((ref) => null);
void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      routes: {
        '/space_galaxy_shooter/screens/login/login_screen': (context) =>
            const LoginScreen(),
        '/space_galaxy_shooter/screens/game_play/game_play_screen': (context) =>
            GamePlayScreen(),
        '/space_galaxy_shooter/screens/menu_screen/menu_screen': (context) =>
            const MenuScreen(),
      },
    );
  }
}
