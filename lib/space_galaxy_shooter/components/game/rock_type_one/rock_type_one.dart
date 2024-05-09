import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_main/game_main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/interfaces/rock_type_one_position/rock_type_one_position.dart';

class RockTypeOne extends SpriteComponent
    with HasGameRef<GameMain>, CollisionCallbacks {
  final double height;
  final double wight;
  final RockTypeOnePosition rockPosition;
  RockTypeOne(
      {required this.height, required this.wight, required this.rockPosition})
      : super();
}
