import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game/background/background_game.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game/user_ship/user_ship.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game_groups/group_rock_type_one/group_rock_type_one.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game_groups/group_rock_type_two/group_rock_type_two.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_utils/game_config/game_configuration.dart';
import 'dart:math';

class GameMain extends FlameGame with TapDetector, HasCollisionDetection {
  GameMain();
  late UserShip userShip;
  late TextComponent score;
  static int remaningTime = 1000;
  final Random random = Random();
  Timer loopTypeOne = Timer(Config.intervalRockTypeOne, repeat: true);
  Timer loopTypeTwo = Timer(Config.intervalRockTypeTwo, repeat: true);
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    if (remaningTime == 1000) {
      score = TextComponent(text: "Score: 0");
    }
    addAll([
      BackgroundGame(),
      userShip = UserShip(),
      GroupRockTypeOne(),
      GroupRockTypeTwo(),
      score = buildScore(score.text.toString()),
    ]);
    debugMode = true;
    loopTypeOne.onTick = () => add(GroupRockTypeOne());
    loopTypeTwo.onTick = () => add(GroupRockTypeTwo());
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    final tapX = info.eventPosition.global.x;
    final tapY = info.eventPosition.global.y;
    final screenWidth = size.x;
    final screenHeight = size.y;

    if ((tapX < screenWidth / 2) && (tapY > screenHeight / 2)) {
      userShip.moveLeft();
      userShip.shoot();
    } else if ((tapX > screenWidth / 2) && (tapY > screenHeight / 2)) {
      userShip.moveRight();
      userShip.shoot();
    } else if ((tapX < screenWidth / 2) && (tapY < screenHeight / 2)) {
      userShip.moveUp();
      userShip.shoot();
    } else if ((tapX > screenWidth / 2) && (tapY < screenHeight / 2)) {
      userShip.moveDown();
      userShip.shoot();
    }
  }

  TextComponent buildScore(String score) {
    return TextComponent(
        text: score,
        position: Vector2(size.x / 2, size.y / 2 * 0.2),
        anchor: Anchor.center,
        textRenderer: TextPaint(
            style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white)));
  }

  @override
  void update(double dt) {
    super.update(dt);
    loopTypeOne.update(dt);
    loopTypeTwo.update(dt);
    score.text = "Score: ${remaningTime}";
    // debugPrint("Step 1");
    if (remaningTime > 0) {
      debugPrint("Step 2");
      // countDownTimer.update(dt);
      remaningTime -= 1;
      // score.text = "Score: ${userShip.score}";
      score.text = "Score: ${remaningTime}";
    }
    if (remaningTime <= 0) {
      debugPrint("Step 3");
      pauseEngine();
      remaningTime = 0;
      overlays.add("gameOver");
    }
  }
}
