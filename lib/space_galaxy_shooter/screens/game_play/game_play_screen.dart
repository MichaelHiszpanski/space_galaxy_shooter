import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_main/game_main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_utils/game_config/game_configuration.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/game_over/game_over_screen.dart';

class GamePlayScreen extends StatelessWidget {
  final GameMain game;
  GamePlayScreen({Key? key})
      : game = GameMain(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Config.gameScreenSize,
        height: Config.gameScreenSize,
        child: GameWidget(
          game: game,
          overlayBuilderMap: {
            // 'mainMenu': (context, _) => MainMenuScreen(game: game),
            'gameOver': (context, _) => GameOverScreen(
                  game: game,
                  scoreEndGame: game.score.toString(),
                )
          },
        ),
      ),
    );
  }
}
