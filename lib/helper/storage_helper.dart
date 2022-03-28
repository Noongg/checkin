import 'package:get_storage/get_storage.dart';

class StorageHelper {
  static GetStorage box = GetStorage();

  static const String KEY_AUTH = "auth";

  // static Future<void> setAuth({AuthModel? authModel}) async {
  //   await box.write(
  //     KEY_AUTH,
  //     jsonEncode(authModel),
  //   );
  // }
  //
  // static Future<AuthModel?> getAuth() async {
  //   if (box.read(KEY_AUTH) != null) {
  //     String authEncode = await box.read(KEY_AUTH);
  //     return AuthModel.fromJson(jsonDecode(authEncode));
  //   }
  //   return null;
  // }

  static Future<void> clearLogin() async {
    await box.remove(KEY_AUTH);
  }
}
