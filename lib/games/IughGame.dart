import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../bodies/GotaBody.dart';
import '../bodies/TierraBody.dart';
import '../configs/config.dart';
import '../players/EmberPlayer.dart';
import '../players/JetPlayer.dart';

class IughGame extends Forge2DGame with
  HasKeyboardHandlerComponents, HasCollisionDetection {

  late EmberPlayerBody _ember;
  late JetPlayerBody _jet;
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

    ObjectGroup? gotas = mapComponent.tileMap.getLayer<ObjectGroup>("gotas");

    for(final gota in gotas!.objects){

      GotaBody gotaBody = GotaBody(posXY: Vector2(gota.x,gota.y),
          tamWH: Vector2(64*wScale,64*hScale));
      gotaBody.onBeginContact = InicioContactosDelJuego;
      add(gotaBody);
    }

    ObjectGroup? tierras = mapComponent.tileMap.getLayer<ObjectGroup>("tierra");

    for(final tiledObjectTierra in tierras!.objects){
      TierraBody tierraBody = TierraBody(tiledBody: tiledObjectTierra,
          scales: Vector2(wScale,hScale));
      //tierraBody.onBeginContact=InicioContactosDelJuego;
      add(tierraBody);
    }

    _ember = EmberPlayerBody(
        initialPosition: Vector2(128, canvasSize.y - 350),
        iTipo: EmberPlayerBody.I_PLAYER_TANYA,
        tamano: Vector2(32,32)
    );

    world.add(_ember);

    _jet = JetPlayerBody(
        initialPosition: Vector2(128, canvasSize.y - 350),
        iTipo: EmberPlayerBody.I_PLAYER_TANYA,
        tamano: Vector2(32,32)
    );

    world.add(_jet);
  }
  @override
  Color backgroundColor() {
    return const Color.fromRGBO(102, 178, 255, 1.0);
  }

  void InicioContactosDelJuego(Object objeto, Contact contact){
    if(objeto is GotaBody){
      //print("ES CONTACTO DE GOTABODY");
      //objeto.removeFromParent();
    }
    else if(objeto is EmberPlayerBody){
      print("ES CONTACTO DE EMBERBODY");
      _ember.iVidas--;
      if(_ember.iVidas == 0){
        _ember.removeFromParent();
      }
    } else if(objeto is JetPlayerBody){
      print("ES CONTACTO DE EMBERBODY");
      _jet.iVidas--;
      if(_jet.iVidas == 0){
        _jet.removeFromParent();
      }
    }
  }
}