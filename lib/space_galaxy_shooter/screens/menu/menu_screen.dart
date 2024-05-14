import 'package:flutter/material.dart';
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
          child: Column(
        children: [
          FloatingActionButton(
            onPressed: () => _navigateToPlayGame(context),
            child: const Text('Start Game'),
          ),
          FloatingActionButton(
            onPressed: () => _navigateToResultsScreen(context),
            child: const Text('Results'),
          ),
        ],
      )),
    );
  }
}
