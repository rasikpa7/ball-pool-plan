import 'package:flutter/material.dart';

class DraggableBall extends StatelessWidget {
  const DraggableBall({super.key, required this.ball,
  required this.isMoved});
  final ball;
  final isMoved;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 10,height: 40,
      child: isMoved == true?
      Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Stack(
          children: [
            Image.asset(ball),
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey.withOpacity(0.7),
            )
          ],
        ),
      ):
       Draggable<String>(
        data: ball,
        
        childWhenDragging:Image.asset(ball,color: Colors.grey[500],) ,
        child: Image.asset(ball),
         feedback: Image.asset(ball)),
    );
  }
}