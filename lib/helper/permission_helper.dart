import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<PermissionStatus> _requestWhenDeny(
      Permission permission, String titleNotGranted) async {
    PermissionStatus status = await permission.request();
    if (status == PermissionStatus.permanentlyDenied) {
      await _showDialogWhenDenied(title: titleNotGranted);
    }
    return status;
  }

  static Future<void> requestPermission({
    @required Function? onGranted,
    Permission permission = Permission.camera,
    String titleNotGranted = "Permission denied!",
  }) async {
    PermissionStatus status;
    status = await permission.status;
    switch (status) {
      case PermissionStatus.granted:
        break;
      case PermissionStatus.denied:
        status = await _requestWhenDeny(permission, titleNotGranted);
        break;
      case PermissionStatus.permanentlyDenied:
        await _showDialogWhenDenied(title: titleNotGranted);
        break;
      default:
        break;
    }
    if ((status.isGranted || status.isLimited) && onGranted != null) {
      await onGranted();
    }
  }

  static Future<void> _showDialogWhenDenied({String title = ""}) async {
    return await Get.defaultDialog(
      title: '',
      backgroundColor: Colors.black54,
      radius: 8,
      content: Text(
        title,
      ),
      confirm: ElevatedButton(
        onPressed: () => openAppSettings(),
        child: const Text('Mở cài đặt'),
      ),
    );
  }
}
