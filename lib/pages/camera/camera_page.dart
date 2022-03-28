import 'package:check_in/pages/camera/widgets/camera_preview.dart';
import 'package:check_in/pages/camera/widgets/camera_shot_button.dart';
import 'package:check_in/pages/camera/widgets/change_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controller/camera_controller.dart';
import '../../utils/icons.dart';


class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ControllerCamera>(
          init: ControllerCamera(),
          builder: (_camera) => FutureBuilder<void>(
              future: _camera.initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 60,
                            color: const Color(0xff0F296D),
                            child: Row(
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(left: 20)),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                ),
                                const CircleAvatar(),
                                const Padding(
                                    padding: EdgeInsets.only(left: 20)),
                                const Text(
                                  'Take photo continue',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Inter-Light',
                                      color: Colors.white,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          Expanded(flex: 1, child: cameraPreviewWidget()),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 90,
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                  top: 15, bottom: 15, left: 40, right: 40),
                              color: Colors.black,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: _camera.checkFlash == true
                                        ? const Icon(
                                            Icons.flash_on,
                                            color: Colors.orange,
                                          )
                                        : const Icon(Icons.flash_off),
                                    color: Colors.white,
                                    onPressed: () {
                                      _camera.changeFlash();
                                    },
                                  ),
                                  cameraControlWidget(context),
                                  cameraToggleRowWidget(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Positioned(child: SvgPicture.asset(IconUtils.icFrames))
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }
}
