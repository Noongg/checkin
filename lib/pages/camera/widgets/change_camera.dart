
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/camera_controller.dart';

// đổi icon camera khi thay đổi vị trí camera
Widget cameraToggleRowWidget() {
  ControllerCamera camera = Get.find();
  if (camera.listCameras.isEmpty) {
    return const Spacer();
  }
  CameraDescription selectedCamera = camera.listCameras[camera.selectedCameraIndex];
  CameraLensDirection lensDirection = selectedCamera.lensDirection;

  return Align(
    alignment: Alignment.centerLeft,
    child: IconButton(
      onPressed: _onSwitchCamera,
      icon: Icon(
        _getCameraLensIcon(lensDirection),
        color: Colors.white,
        size: 24,
      ),

    ),
  );
}

// sự kiện đổi vị trí camera
void _onSwitchCamera() {
  ControllerCamera camera = Get.find();
  camera.selectedCameraIndex = camera.selectedCameraIndex < camera.listCameras.length - 1
      ? camera.selectedCameraIndex + 1
      : 0;
  CameraDescription selectedCamera = camera.listCameras[camera.selectedCameraIndex];
  _initCameraController(selectedCamera);
}

// set lại camera khi bấm nút đổi
Future _initCameraController(CameraDescription cameraDescription) async {
  ControllerCamera camera = Get.find();
  await camera.controller!.dispose();
  camera.controller =
      CameraController(cameraDescription, ResolutionPreset.ultraHigh);

  await camera.controller!.initialize();
  camera.checkFlash = false;
  camera.update();
}

// đổi icon camera
IconData _getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return CupertinoIcons.switch_camera;
    case CameraLensDirection.front:
      return CupertinoIcons.switch_camera_solid;
    case CameraLensDirection.external:
      return Icons.camera;
    default:
      return Icons.device_unknown;
  }
}