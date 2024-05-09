import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game/background/background_game.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game/user_ship/user_ship.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game_groups/group_rock_type_one/group_rock_type_one.dart';

class GameMain extends FlameGame with TapDetector, HasCollisionDetection {
  GameMain();
  late UserShip userShip;
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    addAll([BackgroundGame(), userShip = UserShip(), GroupRockTypeOne()]);
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
}
