import 'package:flutter/material.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_main/game_main.dart';

class GameOverScreen extends StatelessWidget {
  static const String id = "gameOver";
  final GameMain game;
  final String scoreEndGame;
  const GameOverScreen(
      {super.key, required this.game, required this.scoreEndGame});

  @override
  Widget build(BuildContext context) {
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
                height: 100,
              ),
              Text(
                scoreEndGame,
                style: const TextStyle(fontSize: 60, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: onRestart,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text(
                  "Restart",
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onRestart() {
    game.userShip.reset();
    game.overlays.remove("gameOver");
    GameMain.remaningTime = 1000;
    game.resumeEngine();
  }
}
