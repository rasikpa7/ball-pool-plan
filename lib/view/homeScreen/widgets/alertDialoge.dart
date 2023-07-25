import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:machine_test/controller/HomeController.dart';

class AlertDialogeColorPickerWidget extends StatelessWidget {
  const AlertDialogeColorPickerWidget({
    super.key,
    required this.pickerColor,
    required this.controller,
  });

  final Color pickerColor;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Pick a color'),
      content: SingleChildScrollView(
          child: ColorPicker(
        pickerColor: pickerColor,
        onColorChanged: (value) {
          controller.selectedColor.value = value;
        },
      )),
      actions: [
        ElevatedButton(
            onPressed: () {
              log('picked color is $pickerColor');

              Navigator.pop(context);

              Get.snackbar('Brush color changed',
                  'brush color is changed',
                  backgroundColor:
                      controller.selectedColor.value,
                  snackPosition: SnackPosition.BOTTOM);
            },
            child: Text('Done'))
      ],
    );
  }
}