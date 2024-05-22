import 'dart:async';
import 'package:flame/effects.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game/rock_type_one/rock_type_one.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game/rock_type_three/rock_type_three.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game/rock_type_two/rock_type_two.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game/user_ship_ammo/user_ship_ammo.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_main/game_main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/interfaces/user_ship_movement/user_ship_movement.dart';

class UserShip extends SpriteGroupComponent<UserShipMovement>
    with HasGameRef<GameMain>, CollisionCallbacks {
  UserShip();
  final userMovementsEffect = [];
  // int score = 0;
  @override
  FutureOr<void> onLoad() async {
    final userShip = await gameRef.loadSprite("ship.png");
    size = Vector2(50, 40);
    position = Vector2(150, 600);
    current = UserShipMovement.stop;
    sprites = {
      UserShipMovement.stop: userShip,
      UserShipMovement.up: userShip,
      UserShipMovement.down: userShip,
      UserShipMovement.left: userShip,
      UserShipMovement.right: userShip
    };
    add(CircleHitbox());
  }

  void shoot() {
    final ammo =
        UserShipAmmo(positionAmmo: position + Vector2(size.x / 2, -size.y / 2));
    gameRef.add(ammo);
  }

  void moveUp() {
    if (position.y > 0) {
      userMovementsEffect
          .add(MoveByEffect(Vector2(0, -30), EffectController(duration: 0.1)));
      current = UserShipMovement.up;
    }
  }

  void moveDown() {
    if (position.y < 900 - size.y * 2) {
      userMovementsEffect
          .add(MoveByEffect(Vector2(0, 30), EffectController(duration: 0.1)));
      current = UserShipMovement.down;
    }
  }

  void moveLeft() {
    if (position.x > 0 + size.y * 2) {
      userMovementsEffect
          .add(MoveByEffect(Vector2(-30, 0), EffectController(duration: 0.1)));
      current = UserShipMovement.left;
    }
  }

  void moveRight() {
    if (position.x < 900 - size.y * 2) {
      userMovementsEffect
          .add(MoveByEffect(Vector2(30, 0), EffectController(duration: 0.1)));
      current = UserShipMovement.right;
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is RockTypeOne) {
      gameOver();
    }
    if (other is RockTypeTwo) {
      gameOver();
    }
    if (other is RockTypeThree) {
      gameOver();
    }
  }

  void gameOver() {
    gameRef.overlays.add("gameOver");
    gameRef.pauseEngine();
  }

  void reset() {
    gameRef.resumeEngine();
  }

  @override
  void update(double dt) {
    if (userMovementsEffect.isNotEmpty) {
      add(userMovementsEffect.removeAt(0));
    }
  }
}
