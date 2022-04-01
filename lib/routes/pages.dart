import 'package:check_in/bindings/register_binding.dart';
import 'package:check_in/pages/auth/register_page.dart';
import 'package:check_in/routes/routes.dart';
import 'package:get/get.dart';

import '../bindings/camera_bindings.dart';
import '../bindings/checkin_binding.dart';
import '../bindings/login_binding.dart';
import '../pages/auth/login_page.dart';
import '../pages/camera/camera_page.dart';
import '../pages/home/home.dart';

class Pages {
  static final pages = [

    GetPage(
      name: Routes.CAMERAPAGE,
      page: () => const CameraPage(),
      binding: CameraBindings(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.LOGIN_PAGE,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.HOMEPAGE,
      binding: CheckInBindings(),
      page: () => HomePage(),
      transition: Transition.cupertinoDialog,
    ),
    GetPage(
      name: Routes.RESGISTER_PAGE,
      binding: RegisterBinding(),
      page: () => RegisterPage(),
    ),
  ];
}
