import 'dart:math';
import 'package:flame/components.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game/rock_type_three/rock_type_three.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_main/game_main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_utils/game_config/game_configuration.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/interfaces/rock_type_three_position/rock_type_three_position.dart';

class GroupRockTypeThree extends PositionComponent with HasGameRef<GameMain> {
  final double gameWidth;
  GroupRockTypeThree({required this.gameWidth});

  @override
  Future<void> onLoad() async {
    position.x = 10;

    addAll([
      RockTypeThree(
          height: Config.rockTypeThreeSize,
          wight: Config.rockTypeThreeSize,
          rockPosition: RockTypeThreePosition.middle,
          gameWidth: gameWidth),
    ]);
  }

  @override //delta
  void update(double dt) {
    super.update(dt);
    position.y += Config.gameSpeed * dt;

    if (position.y > 700) {
      removeFromParent();
    }
  }
}
