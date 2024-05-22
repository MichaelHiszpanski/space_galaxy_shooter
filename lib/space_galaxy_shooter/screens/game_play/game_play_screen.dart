import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_galaxy_shooter/main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_main/game_main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/game_over/game_over_screen.dart';

class GamePlayScreen extends ConsumerWidget {
  const GamePlayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = ref.watch(mobileScreenSize);
    final game = GameMain(screenSize: screenSize);
    return Scaffold(
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: GameWidget(
          game: game,
          overlayBuilderMap: {
            'gameOver': (context, _) => GameOverScreen(
                  //overflow screen on Flame
                  game: game,
                  scoreEndGame: game.score.toString(),
                )
          },
        ),
      ),
    );
  }
}
