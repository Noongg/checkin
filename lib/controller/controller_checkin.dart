import 'package:camera/camera.dart';
import 'package:check_in/helper/permission_helper.dart';
import 'package:check_in/helper/storage_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class ControllerCheckIn extends GetxController {
  double? lati;
  double? longti;
  String? address;
  Set<Marker> marker = {};
  GoogleMapController? mapController;
  bool checkMap = false;
  String? imgPath;
  // UserModel? user = UserModel();

  @override
  void onInit() {
    super.onInit();
    // getProfile();
    perMissionLocation();
  }

  // void saveId(int? id) {
  //   StorageHelper.box.write(StorageHelper.KEY_SAVE_ID, id);
  // }

  void saveImage(XFile? imgPath) {
    this.imgPath = imgPath!.path;
    update();
  }

  // void getProfile() async {
  //   user = await AuthRepository.getProfile();
  //   update();
  // }

  void perMissionLocation() async {
    await PermissionHelper.requestPermission(
        onGranted: () {}, permission: Permission.location);
    getLocation();
  }

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lati = position.latitude;
    longti = position.longitude;
    update();
    List<Placemark> placeMarks = await placemarkFromCoordinates(lati!, longti!);
    Placemark placeMark = placeMarks[0];
    address =
        '${placeMark.street}, ${placeMark.subAdministrativeArea}, ${placeMark.administrativeArea}';
    marker.add(Marker(
        draggable: true,
        markerId: const MarkerId("id-1"),
        position: LatLng(lati!, longti!),
        infoWindow: InfoWindow(title: address)));
    checkMap = true;
    if (kDebugMode) {
      print(address);
    }
    update();
  }
}
