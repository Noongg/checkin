import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'package:permission_handler/permission_handler.dart';
import '../../controller/auth/auth_controller.dart';
import '../../controller/controller_checkin.dart';
import '../../controller/controller_time.dart';
import '../../helper/permission_helper.dart';
import '../../helper/storage_helper.dart';
import '../../routes/routes.dart';
import '../../utils/icons.dart';
import '../../widgets/loading_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final ControllerCheckIn controllerCheckIn = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SafeArea(
          child: GetBuilder(
            init: ControllerCheckIn(),
            builder: (ControllerCheckIn controller) => Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    Container(
                      height: 60,
                      color: const Color(0xff0F296D),
                      child: Row(
                        children: [
                          const Padding(padding: EdgeInsets.only(left: 20)),
                          const CircleAvatar(),
                          const Padding(padding: EdgeInsets.only(left: 20)),
                          Text(
                            "",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'InterLight',
                                color: Colors.white,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    customMapAndTime(context: context),
                    Expanded(
                      child: controller.imgPath != null
                          ? showImage(
                              context: context, imagePath: controller.imgPath!)
                          : customButtonTime(),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
                controllerCheckIn.imgPath != null
                    ? changeBtnCheck(
                        context: context, imagePath: controllerCheckIn.imgPath)
                    : Positioned(
                        top: MediaQuery.of(context).size.height * 0.32,
                        child: GestureDetector(
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: const Color(0xff0F296D)),
                            child: Center(
                              child: StorageHelper.box
                                          .read(StorageHelper.KEY_CHECK_IN) ==
                                      null
                                  ? const Center(
                                      child: Text(
                                        'Check in',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    )
                                  : const Center(
                                      child: Text(
                                        'Check out',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                            ),
                          ),
                          onTap: () {
                            PermissionHelper.requestPermission(
                              onGranted: () {
                                PermissionHelper.requestPermission(
                                    onGranted: () {
                                      controllerCheckIn.getLocation();
                                      PermissionHelper.requestPermission(
                                        permission: Permission.microphone,
                                        onGranted: () {
                                          Get.toNamed(Routes.CAMERAPAGE);
                                        },
                                      );
                                    },
                                    permission: Permission.location);
                              },
                            );
                          },
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customMapAndTime({required BuildContext context}) {
    return Column(
      children: [
        GetBuilder<ControllerCheckIn>(
          init: ControllerCheckIn(),
          builder: (loadMap) => loadMap.checkMap
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    markers: loadMap.marker,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(loadMap.lati!, loadMap.longti!),
                        zoom: 18),
                    onMapCreated: (GoogleMapController controller) {
                      loadMap.mapController = controller;
                    },
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
        const Padding(padding: EdgeInsets.only(top: 80)),
        GetBuilder<ControllerTime>(
          id: 'checkTime',
          init: ControllerTime(),
          builder: (checkTime) => Column(
            children: [
              Text(
                checkTime.formatter,
                style: const TextStyle(fontSize: 24, fontFamily: 'InterBold'),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                checkTime.getTime,
                style: const TextStyle(fontSize: 14, fontFamily: 'InterBold'),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
            ],
          ),
        ),
      ],
    );
  }

  Widget changeBtnCheck({required BuildContext context, String? imagePath}) {
    return StorageHelper.box.read(StorageHelper.KEY_CHECK_IN) == null
        ? customCheckIn(context: context, imagePath: imagePath!)
        : customCheckOut(context: context, imagePath: imagePath!);
  }

  Widget customCheckIn(
      {required BuildContext context, required String imagePath}) {
    ControllerCheckIn checkIn = Get.find();
    ControllerTime controllerTime = Get.find();
    AuthController authController = Get.find();
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.32,
      child: GestureDetector(
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color(0xff0F296D)),
          child: const Center(
            child: Text(
              "Check in",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
        onTap: () async {
          Get.dialog(const LoadingWidget());
          if (authController.isCheckInternet == true) {
            Get.bottomSheet(
              Container(
                height: 380,
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 50)),
                    SvgPicture.asset(IconUtils.icSuccess),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    const Text(
                      "Check in thành công",
                      style: TextStyle(fontSize: 16, fontFamily: 'InterBold'),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 100)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff0F296D),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        minimumSize:
                        Size(MediaQuery.of(context).size.width, 60),
                      ),
                      onPressed: () {
                        Get.offAllNamed(Routes.HOMEPAGE);
                      },
                      child: const Text(
                        'Đóng',
                        style:
                        TextStyle(fontSize: 14, fontFamily: 'InterBold'),
                      ),
                    )
                  ],
                ),
              ),
              isDismissible: false,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
              ),
            );
          } else {
            Get.snackbar('Thông báo', 'Mất mạng');
          }
        },
      ),
    );
  }

  Widget customCheckOut(
      {required BuildContext context, required String imagePath}) {
    AuthController authController = Get.find();
    ControllerCheckIn checkOut = Get.find();
    ControllerTime controllerTime = Get.find();
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.32,
      child: GestureDetector(
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color(0xff0F296D)),
          child: const Center(
            child: Text(
              "Check out",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
        onTap: () async {
          Get.dialog(const LoadingWidget());
          if (authController.isCheckInternet == true) {
            Get.bottomSheet(
              Container(
                height: 380,
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 50)),
                    SvgPicture.asset(IconUtils.icSuccess),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    const Text(
                      "Check out thành công",
                      style: TextStyle(fontSize: 16, fontFamily: 'InterBold'),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 100)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff0F296D),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        minimumSize:
                        Size(MediaQuery.of(context).size.width, 60),
                      ),
                      onPressed: () {
                        Get.offAllNamed(Routes.HOMEPAGE);
                      },
                      child: const Text(
                        'Đóng',
                        style:
                        TextStyle(fontSize: 14, fontFamily: 'InterBold'),
                      ),
                    )
                  ],
                ),
              ),
              isDismissible: false,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
              ),
            );
          } else {
            Get.snackbar('Thông báo', 'Mất mạng');
          }
        },
      ),
    );
  }
}

Widget showImage({required BuildContext context, String? imagePath}) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(Routes.CAMERAPAGE);
    },
    child: Image.file(
      File(imagePath!),
      width: MediaQuery.of(context).size.width * 0.9,
      fit: BoxFit.cover,
    ),
  );
}

Widget customButton(
    {required VoidCallback callback,
    required String title,
    required String img}) {
  return GestureDetector(
    onTap: () {
      callback();
    },
    child: Container(
      height: 70,
      width: 155,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          const Padding(padding: EdgeInsets.only(left: 10)),
          SvgPicture.asset(img),
          const Padding(padding: EdgeInsets.only(left: 10)),
          Text(
            title,
            style: const TextStyle(fontFamily: 'InterBold', fontSize: 13),
          )
        ],
      ),
    ),
  );
}

Widget customButtonTime() {
  return Column(
    children: [
      StorageHelper.box.read(StorageHelper.KEY_CHECK_IN) == null
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                'Bạn đã chấm công vào lúc ${StorageHelper.box.read(StorageHelper.KEY_CHECK_TIME)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff0F296D),
                    fontFamily: 'InterLight'),
              ),
            ),
      const SizedBox(
        height: 10,
      ),
      Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(padding: EdgeInsets.only(left: 10)),
              customButton(
                  callback: () {
                    StorageHelper.clearLogin();
                    StorageHelper.box.remove(StorageHelper.KEY_CHECK_IN);
                  },
                  title: 'Đi muộn/\nNghỉ phép',
                  img: IconUtils.icMenu),
              customButton(
                  callback: () {
                    Get.toNamed(Routes.TIMESHEETS);
                  },
                  title: 'Bảng chấm\ncông',
                  img: IconUtils.icCalendar),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    ],
  );
}
