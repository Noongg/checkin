import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/camera_controller.dart';

// show màn camera
Widget cameraPreviewWidget() {
  ControllerCamera camera = Get.find();
  if (!camera.controller!.value.isInitialized) {
    return const Text(
      'Loading...',
      style: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  return AspectRatio(
    aspectRatio: camera.controller!.value.aspectRatio,
    child: CameraPreview(camera.controller!),
  );
}
