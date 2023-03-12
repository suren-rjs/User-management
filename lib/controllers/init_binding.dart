import 'package:get/get.dart';
import 'package:user_management/controllers/auth_controller.dart';
import 'package:user_management/controllers/users_controller.dart';
import 'package:user_management/in_app_storage/secure_storage.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    secureStorage.init();
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => UsersController());
  }
}
