import 'package:get/get.dart';
import 'package:user_management/controllers/users_controller.dart';
import 'package:user_management/data_models/login.dart';
import 'package:user_management/data_models/user.dart';
import 'package:user_management/in_app_storage/secure_storage.dart';

class AuthController extends GetxController {
  var usersController = Get.find<UsersController>();

  Future<bool> signIn(Login login) async {
    List<User> users = await usersController.getAllUsers();
    User loginUser;
    try {
      loginUser = users
          .where((user) =>
              user.contact == login.username &&
              user.password == login.password &&
              user.isActive)
          .first;
      usersController.userDetails = loginUser;
      return await secureStorage
          .add('loginUserId', '${loginUser.id}')
          .then((value) => true);
    } catch (e) {
      return false;
    }
  }

  Future<bool> logOut() async {
    await secureStorage.delete('isAdmin');
    return await secureStorage.delete('loginUser').then((value) => true);
  }

  Future<bool> signUp(User user) async {
    if (await usersController.findByUserContact(user.contact) != null) {
      return false;
    } else {
      return await usersController.addNewUser(user).then((value) => true);
    }
  }

  Future<User?> updateUser(User? user) async {
    await usersController.updateUser(user!);
    return await usersController.findByUserId('${user.id}');
  }
}
