import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_galaxy_shooter/main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/ui/custom_floating_button/custom_floating_button.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_utils/game_config/game_configuration.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_utils/user_provider/user_provider.dart';
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
    print("Use Data MENU ${user}");
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
                      height: 160.0,
                    ),
                    Text(
                      'Hello, let`s play: ${user['login'] ?? "Guest"}',
                      style: const TextStyle(
                          fontSize: 60,
                          color: Color.fromARGB(255, 182, 38, 13),
                          fontWeight: FontWeight.w600),
                    ),
                    // Text(
                    //   'Scores: ${user['scores']?.join(", ") ?? "No scores"}',
                    //   style: const TextStyle(
                    //     fontSize: 32,
                    //     color: Color.fromARGB(255, 226, 68, 19),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomFloatingButton(
                      onPressed: () => _navigateToPlayGame(context),
                      buttonName: 'Start Game',
                      heroTag: "tag_game_menu_start",
                    ),
                    const SizedBox(
                      height: 400.0,
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
      )),
    );
  }
}
