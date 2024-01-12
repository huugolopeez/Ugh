import 'dart:async';
import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/forge2d_game.dart';

import '../players/EmberPlayer.dart';

class IughGame extends Forge2DGame with
  HasKeyboardHandlerComponents, HasCollisionDetection {

  late EmberPlayer _ember, _jet;
  late final CameraComponent cameraComponent;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'ember.png',
      'heart.png',
      'heart_half.png',
      'star.png',
      'water_enemy.png'
      ]);

    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);

    _ember = EmberPlayer(
      position: Vector2(128, canvasSize.y - 70),
    );
    world.add(_ember);
  }
  @override
  Color backgroundColor() {
    return const Color.fromRGBO(102, 178, 255, 1.0);
  }
}