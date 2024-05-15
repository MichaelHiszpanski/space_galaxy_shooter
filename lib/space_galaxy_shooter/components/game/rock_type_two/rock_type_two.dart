import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game/user_ship_ammo/user_ship_ammo.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_main/game_main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/interfaces/rock_type_two_position/rock_type_two_position.dart';
import 'package:flame/flame.dart';

class RockTypeTwo extends SpriteComponent
    with HasGameRef<GameMain>, CollisionCallbacks {
  final double height;
  final double wight;
  late int rockLife;
  final RockTypeTwoPosition rockPosition;
  RockTypeTwo(
      {required this.height, required this.wight, required this.rockPosition})
      : super();
  @override
  Future<void> onLoad() async {
    final rock = await Flame.images.load("rock_type_two.png");
    size = Vector2(wight, height);
    rockLife = 2;
    position = Vector2(50, 0);
    switch (rockPosition) {
      case RockTypeTwoPosition.left:
        position.y = 80;
        position.x = 200;
        sprite = Sprite(rock);
        break;
      case RockTypeTwoPosition.right:
        position.y = 80;
        position.x = 380;
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
