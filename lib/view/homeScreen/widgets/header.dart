

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/const/header.dart';

import 'package:machine_test/controller/HomeController.dart';
import 'package:machine_test/view/homeScreen/widgets/alertDialoge.dart';
import 'package:screenshot/screenshot.dart';

class Header extends StatefulWidget {
  Header({super.key, required this.function, required this.controller});
  final Function? function;

  final ScreenshotController controller;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Color pickerColor = Color(0xff443a48);

  Color currentColot = Color(0xff443a49);
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HeaderActionButtons(
                function: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialogeColorPickerWidget(pickerColor: pickerColor, controller: controller);
                    },
                  );
                },
                image: colorPicker),
            HeaderActionButtons(
                image: bigBrush,
                color: controller.isPainterSelected.value == true
                    ? Colors.black
                    : Colors.grey,
                function: () {
                  controller.togglePainterButton();
                }),
            HeaderActionButtons(
              function: () {},
              image: smallBrush,
              color: controller.selectedColor.value,
            ),
            HeaderActionButtons(
                function: () {
                  widget.function!();
                },
                image: reset),
            HeaderActionButtons(function: () async{
              controller.screenshot(controller: widget.controller);

            }, image: screenShot)
          ],
        ),
      ),
    );
  }
}



class HeaderActionButtons extends StatelessWidget {
  const HeaderActionButtons(
      {super.key, required this.function, this.color, this.image});
  final function;
  final image;
  final color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: function,
        child: Image.asset(
          image,
          color: color,
        ));
  }
}
