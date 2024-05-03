import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/background/background_game.dart';

class GameMain extends FlameGame with TapDetector, HasCollisionDetection {
  GameMain();

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    addAll([BackgroundGame()]);
  }
}
