import 'package:flutter/material.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/ui/custom_floating_button/custom_floating_button.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_utils/game_config/game_configuration.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/game_play/game_play_screen.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/game_results/game_results.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  void _navigateToPlayGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GamePlayScreen()),
    );
  }

  void _navigateToResultsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GameResultsScreen()),
    );
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
                        image: AssetImage("assets/images/menu_screen.png"),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 200.0,
                    ),
                    CustomFloatingButton(
                        onPressed: () => _navigateToPlayGame(context),
                        buttonName: 'Start Game'),
                    const SizedBox(
                      height: 400.0,
                    ),
                    CustomFloatingButton(
                        onPressed: () => _navigateToResultsScreen(context),
                        buttonName: 'Results')
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
