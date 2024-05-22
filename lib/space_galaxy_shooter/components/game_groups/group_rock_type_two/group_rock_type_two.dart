import 'dart:math';
import 'package:flame/components.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game/rock_type_two/rock_type_two.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_main/game_main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_utils/game_config/game_configuration.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/interfaces/rock_type_two_position/rock_type_two_position.dart';

class GroupRockTypeTwo extends PositionComponent with HasGameRef<GameMain> {
  GroupRockTypeTwo();

  @override
  Future<void> onLoad() async {
    position.x = 10;

    addAll([
      RockTypeTwo(
          height: Config.rockTypeTwoSize,
          wight: Config.rockTypeTwoSize,
          rockPosition: RockTypeTwoPosition.left),
      RockTypeTwo(
          height: Config.rockTypeTwoSize,
          wight: Config.rockTypeTwoSize,
          rockPosition: RockTypeTwoPosition.right)
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
