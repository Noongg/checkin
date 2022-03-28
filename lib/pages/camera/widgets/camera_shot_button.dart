import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/camera_controller.dart';
import '../../../controller/controller_checkin.dart';

// nút chụp
Widget cameraControlWidget(context) {
  return Expanded(
    child: Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(
              Icons.camera,
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            onPressed: () {
              _onCapturePressed(context);
            },
          )
        ],
      ),
    ),
  );
}

// sự kiện chụp
void _onCapturePressed(context) async {
  ControllerCamera camera = Get.find();
  final image = await camera.controller!.takePicture();
  ControllerCheckIn controller = Get.find();
  controller.saveImage(image);
  Get.back();
}
