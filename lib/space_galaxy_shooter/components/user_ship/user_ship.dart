import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_main/game_main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/interfaces/user_ship_movement/user_ship_movement.dart';

class UserShip extends SpriteGroupComponent<UserShipMovement>
    with HasGameRef<GameMain>, CollisionCallbacks {
  UserShip();

  @override
  FutureOr<void> onLoad() async {
    final user_ship = await gameRef.loadSprite("ship.png");
    size = Vector2(50, 40);
    position = Vector2(350, 600);
    current = UserShipMovement.stop;
    sprites = {
      UserShipMovement.stop: user_ship,
      UserShipMovement.up: user_ship,
      UserShipMovement.down: user_ship,
      UserShipMovement.left: user_ship,
      UserShipMovement.right: user_ship
    };
    add(CircleHitbox()); //to acvtive  collision detecion
  }
}
