import 'package:check_in/routes/pages.dart';
import 'package:check_in/routes/routes.dart';
import 'package:check_in/translations/translation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'bindings/login_binding.dart';
import 'controller/auth/auth_controller.dart';
import 'controller/controller_time.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  await GetStorage.init();
  Future.delayed(const Duration(seconds: 1),() {
    FlutterNativeSplash.remove();
  },);
  Get.put<AuthController>(AuthController());
  Get.put<ControllerTime>(ControllerTime());
  initializeDateFormatting('vi_VN', null).then((_) => runApp(MyApp()));

}

class MyApp extends StatelessWidget {
  final AuthController _controller = Get.find();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: _controller.isLogin ? Routes.HOMEPAGE : Routes.LOGIN_PAGE,
      initialBinding: LoginBinding(),
      getPages: Pages.pages,
      locale: const Locale('vi', 'VN'),
      translationsKeys: Translation.translations,
    );
  }
}
