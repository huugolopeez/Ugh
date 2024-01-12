import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:iugh/games/IughGame.dart';

void main() {
  runApp(
    const GameWidget<IughGame>.controlled(
        gameFactory: IughGame.new
    )
  );
}

