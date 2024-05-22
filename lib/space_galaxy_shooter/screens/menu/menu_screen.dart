import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_galaxy_shooter/main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/ui/custom_floating_button/custom_floating_button.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_utils/game_config/game_configuration.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_utils/user_model/user_model.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/game_play/game_play_screen.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/game_results/game_results.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
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
    final user = ref.watch(userLoginProvider) ?? {};
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Expanded(
          child: Column(
            children: [
              Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/menu_screen.png"),
                          fit: BoxFit.cover)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60.0,
                      ),
                      Text(
                        'Hello, let`s play: ${user['login'] ?? "Guest"}',
                        style: const TextStyle(
                            fontSize: 35,
                            color: Color.fromARGB(255, 182, 38, 13),
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      CustomFloatingButton(
                        onPressed: () => _navigateToPlayGame(context),
                        buttonName: 'Start Game',
                        heroTag: "tag_game_menu_start",
                      ),
                      const SizedBox(
                        height: 300.0,
                      ),
                      CustomFloatingButton(
                        onPressed: () => _navigateToResultsScreen(context),
                        buttonName: 'Results',
                        heroTag: "tag_game_menu_results",
                      )
                    ],
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
