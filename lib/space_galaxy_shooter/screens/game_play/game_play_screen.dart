import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_main/game_main.dart';

class GamePlayScreen extends StatelessWidget {
  final GameMain game;
  GamePlayScreen({Key? key})
      : game = GameMain(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 800,
        height: 800,
        child: GameWidget(game: game),
      ),
    );
  }
}
