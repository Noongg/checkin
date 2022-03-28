import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerCamera extends GetxController with WidgetsBindingObserver {
  late List<CameraDescription> listCameras;
  CameraController? controller;
  int selectedCameraIndex = 1;
  Future<void>? initializeControllerFuture;
  bool checkFlash = false;
  bool _initializing = false;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    _initializing = true;
    WidgetsBinding.instance!.addObserver(this);
    _initialize();
  }

  @override
  void onClose() {
    controller!.setFlashMode(FlashMode.off);
    WidgetsBinding.instance!.removeObserver(this);
    controller!.pausePreview();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (_initializing) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller!.pausePreview();
    } else if (state == AppLifecycleState.resumed) {
      _initCameraController(controller!.description);
    }
  }

  Future<void> _initialize() async {
    listCameras = await availableCameras();
    controller = CameraController(listCameras[1], ResolutionPreset.ultraHigh);
    await controller!.initialize();
    _initializing = false; // set to false
    initializeControllerFuture = controller!.initialize();
    update();
  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    await controller!.dispose();
    controller =
        CameraController(cameraDescription, ResolutionPreset.ultraHigh);

    await controller!.initialize();
    checkFlash = false;
    update();
  }

  void changeFlash() {
    if (checkFlash == true) {
      checkFlash = false;
      controller!.setFlashMode(FlashMode.off);
      update();
    } else {
      checkFlash = true;
      controller!.setFlashMode(FlashMode.torch);
      update();
    }
  }
}
