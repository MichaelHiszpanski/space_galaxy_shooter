import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game/background/background_game.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game/user_ship/user_ship.dart';

class GameMain extends FlameGame with TapDetector, HasCollisionDetection {
  GameMain();

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    addAll([BackgroundGame(), UserShip()]);
  }
}
