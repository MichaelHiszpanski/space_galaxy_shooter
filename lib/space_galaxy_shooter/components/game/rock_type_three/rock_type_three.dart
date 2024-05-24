import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game/user_ship_ammo/user_ship_ammo.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_main/game_main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_utils/game_config/game_configuration.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/interfaces/rock_type_three_position/rock_type_three_position.dart';
import 'package:flame/flame.dart';

class RockTypeThree extends SpriteComponent
    with HasGameRef<GameMain>, CollisionCallbacks {
  final double height;
  final double wight;
  late int rockLife;
  final RockTypeThreePosition rockPosition;
  final double gameWidth;
  RockTypeThree(
      {required this.height,
      required this.wight,
      required this.rockPosition,
      required this.gameWidth})
      : super();
  @override
  Future<void> onLoad() async {
    final rock = await Flame.images.load("rock_type_three.png");
    size = Vector2(wight, height);
    rockLife = Config.rockTypeThreeLife;
    position = Vector2(50, 0);
    switch (rockPosition) {
      case RockTypeThreePosition.middle:
        position.y = 40;
        position.x = gameWidth / 2;
        sprite = Sprite(rock);
        break;
    }
    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is UserShipAmmo) {
      rockLife -= 1;
      gameRef.updateScore();
      if (rockLife <= 0) {
        removeFromParent();
      }
      other.removeFromParent();
    }
  }
}
