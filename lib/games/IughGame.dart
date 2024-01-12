import 'dart:async';
import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../bodies/TierraBody.dart';
import '../configs/config.dart';
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

    wScale = size.x/gameWidth;
    hScale = size.y/gameHeight;

    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);

    mapComponent=await TiledComponent.load('mapa1.tmx', Vector2(32*wScale,32*hScale));
    world.add(mapComponent);

    ObjectGroup? tierras=mapComponent.tileMap.getLayer<ObjectGroup>("tierra");

    for(final tiledObjectTierra in tierras!.objects){
      TierraBody tierraBody = TierraBody(tiledBody: tiledObjectTierra,
          scales: Vector2(wScale,hScale));
      //tierraBody.onBeginContact=InicioContactosDelJuego;
      add(tierraBody);
    }

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