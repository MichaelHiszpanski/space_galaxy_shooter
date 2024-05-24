import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_galaxy_shooter/main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/ui/custom_floating_button/custom_floating_button.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/database/mongo_db.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_main/game_main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/game_play/game_play_screen.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/menu/menu_screen.dart';

class GameOverScreen extends ConsumerWidget {
  static const String id = "gameOver";
  final GameMain game;
  final String scoreEndGame;
  const GameOverScreen(
      {super.key, required this.game, required this.scoreEndGame});

  Future<void> updateUserScores(WidgetRef ref) async {
    int endScore = int.parse(scoreEndGame);
    bool shouldUpdate = false;
    var dbService = DatabaseService();
    final user = ref.read(userLoginProvider);
    String userLogin = user?['login'];
    List<int> scores = List<int>.from(user?['scores']);
    print("Users data ${scores[0]}");
    print("Users data ${endScore}");
    if (endScore > scores[0]) {
      scores[0] = endScore;
      shouldUpdate = true;
    }
    if (shouldUpdate) {
      await dbService.updateScores(userLogin, scores);
      ref.read(userLoginProvider.notifier).state = {
        'scores': scores,
      };
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: Container(
          width: 800,
          height: 800,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/gameover.png"),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 80,
              ),
              Text(
                "Your Score: $scoreEndGame",
                style: const TextStyle(
                    fontSize: 38,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomFloatingButton(
                  onPressed: () => _onRestart(context, ref),
                  buttonName: "Play Again !",
                  heroTag: "tag_game_over_screen_restart"),
              const SizedBox(
                height: 400,
              ),
              CustomFloatingButton(
                  onPressed: () => _navigateToMenuScreen(context, ref),
                  buttonName: "Back to Menu",
                  heroTag: "tag_game_over_screen_menu")
            ],
          ),
        ),
      ),
    );
  }

  void _onRestart(BuildContext context, WidgetRef ref) {
    updateUserScores(ref);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GamePlayScreen()),
    );
  }

  void _navigateToMenuScreen(BuildContext context, WidgetRef ref) {
    updateUserScores(ref);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MenuScreen()),
    );
  }
}
