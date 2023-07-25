import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'package:screenshot/screenshot.dart';

class HomeController extends GetxController {
  Uint8List? image;

  RxBool isdownloadingImage = false.obs;

  Rx<Color> selectedColor = Rx<Color>(Colors.black);

  RxBool isPainterSelected = true.obs;

  void togglePainterButton() {
    isPainterSelected.value = !isPainterSelected.value;
    if (isPainterSelected == true) {
      log('true');
      Get.snackbar('Brush on', 'Brush is on now you can plan it!',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      log('false');
    }
  }

  void screenshot({required ScreenshotController controller}) async {
    try {
      await controller.capture().then((value) => image = value);

      Get.dialog(AlertDialog(
        content: Image.memory(image!),
        actions: [
          
          ElevatedButton(
              onPressed: () async {

                final imagepath = await saveImageToLocal(image!);

                log(imagepath);

              

                
              
                  
              
                Get.back();
              },
              child: Text('Save')),
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Back'))
        ],
      ));
    } catch (e) {
      log('something went wrong on sceenshot controller $e');
    }
  }

  

  Future<String> saveImageToLocal(Uint8List imageBytes) async {
   
      log('working');
      isdownloadingImage.value = true;

      Directory? directory = await getExternalStorageDirectory();

      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String fileName = 'screenshot_ballpoll$timestamp.jpeg';

      String filePath = '/storage/emulated/0/Download/$timestamp$fileName';

      File file = File(filePath);
      log('before await');

    file.writeAsBytes(imageBytes);
     

     

      isdownloadingImage.value = false;

      return filePath;
   
  }
}
