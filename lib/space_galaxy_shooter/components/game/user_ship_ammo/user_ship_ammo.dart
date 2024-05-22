import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/game/rock_type_one/rock_type_one.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_main/game_main.dart';

class UserShipAmmo extends SpriteComponent
    with HasGameRef<GameMain>, CollisionCallbacks {
  final Vector2 positionAmmo;
  UserShipAmmo({Key? key, required this.positionAmmo});

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('ammoship.png');
    position = positionAmmo;
    size = Vector2(10, 20);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, -150) * dt;

    if (position.y + size.y < 0) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is RockTypeOne) {
      removeFromParent();
      other.removeFromParent();
    }
  }
}
