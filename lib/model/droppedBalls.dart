import 'dart:ui';

class DroppedBalls {
  String ball;
  Offset position;
  
  DroppedBalls(
      {required this.ball, required this.position, });
}

typedef callBack = void Function();
