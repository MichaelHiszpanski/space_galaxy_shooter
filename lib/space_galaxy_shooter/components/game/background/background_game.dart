import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/painting.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_main/game_main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_utils/game_config/game_configuration.dart';

class BackgroundGame extends ParallaxComponent<GameMain>
    with HasGameRef<GameMain> {
  final Size screenSize;
  BackgroundGame(this.screenSize);
  @override
  FutureOr<void> onLoad() async {
    final backgroundGameImage =
        await Flame.images.load("back3.jpg"); //load image
    final imageSize = Vector2(screenSize.width,
        screenSize.height); //image size same as game screen szie
    parallax = Parallax([
      //Parallax response for mutliple ParallaxLayer objects
      ParallaxLayer(
          ParallaxImage(backgroundGameImage,
              repeat: ImageRepeat.repeatY, fill: LayerFill.width),
          velocityMultiplier: Vector2(0, 0.5))
    ], size: imageSize);
  }

  @override
  void update(double dt) {
    // its called every frame to update
    super.update(dt);
    parallax?.baseVelocity.y = -Config.gameSpeed;
  }
}
