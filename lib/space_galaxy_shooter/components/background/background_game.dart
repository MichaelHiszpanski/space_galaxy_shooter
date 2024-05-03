import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import 'package:space_galaxy_shooter/space_galaxy_shooter/game_main/game_main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_utils/game_config/game_configuration.dart';

class BackgroundGame extends ParallaxComponent<GameMain>
    with HasGameRef<GameMain> {
  BackgroundGame();
  @override
  FutureOr<void> onLoad() async {
    final backgroundGameImage = await Flame.images.load("space.jpg");
    final imageSize = Vector2(Config.gameScreenSize, Config.gameScreenSize);
    parallax = Parallax([
      ParallaxLayer(
          ParallaxImage(backgroundGameImage,
              repeat: ImageRepeat.repeatY, fill: LayerFill.width),
          velocityMultiplier: Vector2(0, 0.5))
    ], size: imageSize);
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.y = -Config.gameSpeed;
  }
}
