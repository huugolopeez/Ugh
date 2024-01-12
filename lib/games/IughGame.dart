import 'dart:async';
import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../players/EmberPlayer.dart';
import '../players/JetPlayer.dart';

class IughGame extends Forge2DGame with
  HasKeyboardHandlerComponents, HasCollisionDetection {

  late EmberPlayer _ember;
  late JetPlayer _jet;
  late final CameraComponent cameraComponent;
  late TiledComponent mapComponent;

  double wScale = 1.0, hScale = 1.0;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'ember.png',
      'jet.png',
      'heart.png',
      'heart_half.png',
      'star.png',
      'water_enemy.png',
      'tilemap1_32.png'
      ]);

    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);

    _ember = EmberPlayer(
      position: Vector2(100, canvasSize.y - 150),
    );

    world.add(_ember);

    _jet = JetPlayer(
      position: Vector2(200, canvasSize.y - 150),
    );

    world.add(_jet);
  }
  @override
  Color backgroundColor() {
    return const Color.fromRGBO(102, 178, 255, 1.0);
  }
}