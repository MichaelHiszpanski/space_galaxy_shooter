import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game/user_ship_ammo/user_ship_ammo.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_main/game_main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/interfaces/rock_type_one_position/rock_type_one_position.dart';
import 'package:flame/flame.dart';

class RockTypeOne extends SpriteComponent
    with HasGameRef<GameMain>, CollisionCallbacks {
  final double height;
  final double wight;
  final RockTypeOnePosition rockPosition;
  final double gameWidth;
  RockTypeOne(
      {required this.height,
      required this.wight,
      required this.rockPosition,
      required this.gameWidth})
      : super();
  @override
  Future<void> onLoad() async {
    final rock = await Flame.images.load("rock_type_one.png");
    size = Vector2(wight, height);

    position = Vector2(50, 0);
    switch (rockPosition) {
      case RockTypeOnePosition.left:
        position.y = 40;
        position.x = gameWidth * 0.2;
        sprite = Sprite(rock);
        break;
      case RockTypeOnePosition.right:
        position.y = 40;
        position.x = gameWidth / 2;
        sprite = Sprite(rock);
        break;
      case RockTypeOnePosition.middle:
        position.y = 40;
        position.x = gameWidth * 0.8;
        sprite = Sprite(rock);
        break;
    }
    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is UserShipAmmo) {
      removeFromParent();
      other.removeFromParent();
      gameRef.updateScore();
    }
  }
}
