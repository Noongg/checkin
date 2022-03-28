import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ControllerTime extends GetxController{
  DateTime dateTime = DateTime.now();
  String formatter='';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDate();

  }
  get getMonthString {
    switch (dateTime.weekday) {
      case 1:
        return 'Thứ 2';
      case 2:
        return 'Thứ 3';
      case 3:
        return 'Thứ 4';
      case 4:
        return 'Thứ 5';
      case 5:
        return 'Thứ 6';
      case 6:
        return 'Thứ 7';
      case 7:
        return 'Chủ nhật';
      default:
        return 'Err';
    }
  }

  void getDate() {
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      formatter = DateFormat.jm().format(DateTime.now());
      update(["checkTime"]);
    });
  }

  get getTime {
    return '$getMonthString,ngày ${dateTime.day},tháng ${dateTime.month},năm ${dateTime.year}';
  }

}