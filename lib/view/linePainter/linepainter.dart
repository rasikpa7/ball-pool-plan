
import 'package:flutter/material.dart';
import 'package:machine_test/view/linePainter/drawlinestratAndEnd.dart';

class LinePainter extends CustomPainter{
  List<Drawline>lines;
  final color;
LinePainter({required this.lines , this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..strokeWidth = 2.0;

    for (var element in lines) {
      canvas.drawLine(element.start, element.end, paint);
      
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
   return oldDelegate != lines;
  }
 
}