import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/const/ball.dart';

import 'package:machine_test/const/homescreenItems.dart';
import 'package:machine_test/controller/HomeController.dart';
import 'package:machine_test/model/droppedBalls.dart';
import 'package:machine_test/view/homeScreen/widgets/appbar.dart';
import 'package:machine_test/view/homeScreen/widgets/draggableBall.dart';
import 'package:machine_test/view/homeScreen/widgets/header.dart';
import 'package:machine_test/view/linePainter/drawlinestratAndEnd.dart';
import 'package:machine_test/view/linePainter/linepainter.dart';
import 'package:screenshot/screenshot.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void handleDrawLine(List<Drawline> newLines) {
    setState(() {
      lines = newLines;
    });
  }

  final whiteball = DroppedBalls(ball: whiteBall, position: Offset(150, 570));

  List<DroppedBalls> droppedBalls = [];

  List<Drawline> lines = [];

  final screenshotController = ScreenshotController();

  removeLastLine() {
    log('line removing');
    if (lines.isNotEmpty) {
      setState(() {
        lines.removeLast();
      });
      Get.snackbar('Line removed', 'your previous line is removed',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void initState() {
   
    // TODO: implement initState
    super.initState();
  }



  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(55), child: PlanItAppBar()),
      body: Stack(
        children: [
          Container(
            color: Color(0xff3f4850),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                color: Color(0xffebf1fa),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Column(
              children: [
                Header(
                    function: removeLastLine, controller: screenshotController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Image.asset(aramithText)],
                ),
                Expanded(
                    child: Stack(
                  children: [
                    Row(
                      children: [
                        DragTarget<String>(
                            onLeave: (e) {
                              log(e.toString());
                              int index = droppedBalls
                                  .indexWhere((element) => element.ball == e);

                              setState(() {
                                droppedBalls.removeAt(index);
                              });
                              setState(() {});
                            },
                            onWillAccept: (ball) => true,
                            onMove: (details) {
                              final RenderBox renderBox =
                                  context.findRenderObject() as RenderBox;
                              final movePosition =
                                  renderBox.globalToLocal(details.offset);
                              print('move position $movePosition');
                            },
                            onAcceptWithDetails: (details) {
                              final renderBox =
                                  context.findRenderObject() as RenderBox;
                              final dropPosition =
                                  renderBox.globalToLocal(details.offset);
                              log(dropPosition.toString());
                              final droppedballWithPostion = DroppedBalls(
                                  ball: details.data, position: dropPosition);
                              setState(() {
                                droppedBalls.add(droppedballWithPostion);
                              });
                            },
                            builder: (context, candidateData, rejectedData) {
                              return Obx(() => Screenshot(
                                    controller: screenshotController,
                                    child: Stack(
                                      children: [
                                        GestureDetector(
                                          onPanStart: (details) {
                                            if (controller
                                                    .isPainterSelected.value ==
                                                true) {
                                              final start =
                                                  details.localPosition;
                                              final line = Drawline(
                                                  start: start, end: start);
                                              handleDrawLine([...lines, line]);
                                            }
                                          },
                                          onPanUpdate: (details) {
                                            if (lines.isNotEmpty) {
                                              final end = details.localPosition;
                                              final updatedLine = lines.last;
                                              final newLines = List.from(lines)
                                                ..removeLast();
                                              handleDrawLine([
                                                ...newLines,
                                                Drawline(
                                                    start: updatedLine.start,
                                                    end: end)
                                              ]);
                                            }
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 7),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image:
                                                        AssetImage(aramithBg),
                                                    fit: BoxFit.contain)),
                                            width: 300,
                                            child: Stack(
                                                children: droppedBalls.map((e) {
                                              return Positioned(
                                                  left: e.position.dx,
                                                  top: e.position.dy - 155,
                                                  child: GestureDetector(
                                                      onPanUpdate: (details) {
                                                        log(details
                                                            .globalPosition
                                                            .toString());
                                                        e.position = details
                                                            .globalPosition;
                                                        setState(() {});
                                                      },
                                                      child:
                                                          Image.asset(e.ball)));
                                            }).toList()),
                                          ),
                                        ),
                                        CustomPaint(
                                          painter: LinePainter(
                                              lines: lines,
                                              color: controller
                                                  .selectedColor.value),
                                        ),
                                      ],
                                    ),
                                  ));
                            }),
                        Expanded(
                          child: ListView.builder(
                            itemCount: ball.length,
                            itemBuilder: (context, index) {
                              bool isMoved = false;
                              isMoved = droppedBalls.any(
                                  (element) => element.ball == ball[index]);
                              return DraggableBall(
                                key: widget.key,
                                ball: ball[index],
                                isMoved: isMoved,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
