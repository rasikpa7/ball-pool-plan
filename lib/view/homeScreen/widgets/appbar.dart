import 'package:flutter/material.dart';
import 'package:machine_test/const/ball.dart';

class PlanItAppBar extends StatelessWidget {
  const PlanItAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(Icons.arrow_back_ios),
      title: Text('Plan it'),
      centerTitle: true,
      actions: [
        Stack(children :[ 
          Container(
            margin: EdgeInsets.only(right: 10,
            top: 
            7.5),
            child: Image.asset('lib/assets/1002.png')),
        Positioned(
          top: 9,left: 3.1,
          
          child: SizedBox(
            width: 31,height: 32,
            child: Image.asset(
              
              ball1),
          ))
        ])
      ],
    );
  }
}