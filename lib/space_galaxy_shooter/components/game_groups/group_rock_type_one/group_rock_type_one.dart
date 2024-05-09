import 'dart:math';
import 'package:flame/components.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game/rock_type_one/rock_type_one.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_main/game_main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_utils/game_config/game_configuration.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/interfaces/rock_type_one_position/rock_type_one_position.dart';

class GroupRockTypeOne extends PositionComponent with HasGameRef<GameMain> {
  GroupRockTypeOne();
  final _random = Random();

  @override
  Future<void> onLoad() async {
    position.x = 10;

    addAll([
      RockTypeOne(
          height: 50, wight: 50, rockPosition: RockTypeOnePosition.left),
      RockTypeOne(
          height: 50, wight: 50, rockPosition: RockTypeOnePosition.middle),
      RockTypeOne(
          height: 50, wight: 50, rockPosition: RockTypeOnePosition.right)
    ]);
  }

  @override //delta
  void update(double dt) {
    super.update(dt);
    position.y += Config.gameSpeed * dt;

    if (position.y > 700) {
      removeFromParent();
    }

    // if (gameRef.isHit) {
    //   removeFromParent();
    //   gameRef.isHit = false;
    // }
  }
}
